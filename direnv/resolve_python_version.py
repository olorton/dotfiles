#!/usr/bin/env python3
"""Resolve which Python version satisfies a poetry project's constraint."""

import argparse
import re
import sys


def _read_constraint(pyproject_path, lock_path):
    try:
        text = open(pyproject_path, encoding="utf-8").read()
    except OSError:
        text = ""
    m = re.search(
        r'(?ms)^\[tool\.poetry\.dependencies\].*?^python\s*=\s*"([^"]+)"', text
    )
    if m:
        return m.group(1)
    m = re.search(r'(?m)^requires-python\s*=\s*"([^"]+)"', text)
    if m:
        return m.group(1)
    try:
        lock_text = open(lock_path, encoding="utf-8").read()
    except OSError:
        lock_text = ""
    m = re.search(r'(?ms)^\[metadata\].*?^python-versions\s*=\s*"([^"]+)"', lock_text)
    if m:
        return m.group(1)
    return None


def _parse_version(v):
    return tuple(int(p) for p in re.findall(r"\d+", v))


def _pad(t, n):
    return t + (0,) * (n - len(t))


def _clause_matches(version, op, target):
    v, t = _parse_version(version), _parse_version(target)
    n = max(len(v), len(t))
    v, t = _pad(v, n), _pad(t, n)
    if op == "==":
        return v == t
    if op == "!=":
        return v != t
    if op == ">=":
        return v >= t
    if op == "<=":
        return v <= t
    if op == ">":
        return v > t
    if op == "<":
        return v < t
    if op in ("~=", "~"):
        upper = list(t)
        if len(upper) >= 2:
            upper[-2] += 1
            upper[-1] = 0
        return v >= t and v < tuple(upper)
    if op == "^":
        upper = list(t)
        for i, part in enumerate(upper):
            if part != 0:
                upper[i] += 1
                for j in range(i + 1, len(upper)):
                    upper[j] = 0
                break
        else:
            upper[-1] += 1
        return v >= t and v < tuple(upper)
    return True


def satisfies(version, constraint):
    for clause in constraint.split(","):
        clause = clause.strip()
        if not clause:
            continue
        m = re.match(r"(==|!=|>=|<=|~=|~|\^|>|<)?\s*([\d.\*]+)", clause)
        if not m:
            continue
        op, target = m.group(1) or "==", m.group(2).replace(".*", "")
        if not _clause_matches(version, op, target):
            return False
    return True


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--pyproject", required=True)
    parser.add_argument("--poetry-lock", required=True)
    parser.add_argument(
        "--candidates",
        required=True,
        help="whitespace-separated list of candidate versions",
    )
    args = parser.parse_args()

    constraint = _read_constraint(args.pyproject, args.poetry_lock)
    if not constraint:
        return 1

    candidates = [c for c in args.candidates.split() if re.match(r"^\d+\.\d+\.\d+$", c)]
    matches = [c for c in candidates if satisfies(c, constraint)]
    if not matches:
        return 1

    matches.sort(key=_parse_version, reverse=True)
    print(matches[0])
    return 0


if __name__ == "__main__":
    sys.exit(main())
