#!/usr/bin/env python3
"""Scaffold a new piece: folder, notes.md frontmatter, type-specific content
stub, then reindex.

Ported from a companion document repo's own scripts/ dir (see that repo's
README.md for the full type/slug/notes.md convention this assumes) so it
can be driven interactively from inside nvim. Operates on the current
working directory, not on wherever this bundle itself is installed — run
it (or the nvim :NewPiece command that wraps it) from inside the target
document repo.

Usage:
  python3 scripts/new_piece.py --type story --name "The Lighthouse Keeper" \\
      --description "A keeper faces down a storm that isn't weather." \\
      [--status idea]
"""
import argparse
import re
import subprocess
import sys
from pathlib import Path

from frontmatter import render

REPO_ROOT = Path.cwd()
TYPE_TO_DIR = {
    "story": "stories",
    "poem": "poems",
    "article": "articles",
    "book": "books",
}
ALLOWED_STATUSES = {"idea", "drafting", "revising", "done"}


def slugify(name):
    slug = re.sub(r"[^a-z0-9]+", "-", name.lower()).strip("-")
    return slug


def parse_args():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--type", required=True, choices=sorted(TYPE_TO_DIR))
    parser.add_argument("--name", required=True)
    parser.add_argument("--description", required=True)
    parser.add_argument("--status", default="idea", choices=sorted(ALLOWED_STATUSES))
    return parser.parse_args()


def main():
    args = parse_args()

    slug = slugify(args.name)
    if not slug:
        print(f"new_piece: {args.name!r} produces an empty slug", file=sys.stderr)
        return 1

    type_dir = TYPE_TO_DIR[args.type]
    piece_dir = REPO_ROOT / type_dir / slug
    if piece_dir.exists():
        print(f"new_piece: {type_dir}/{slug}/ already exists, not overwriting", file=sys.stderr)
        return 1

    piece_dir.mkdir(parents=True)

    notes_text = render(
        {"title": args.name, "status": args.status, "description": args.description}
    )
    (piece_dir / "notes.md").write_text(notes_text)

    if args.type == "book":
        chapters_dir = piece_dir / "chapters"
        chapters_dir.mkdir()
        (chapters_dir / ".gitkeep").write_text("")
    else:
        (piece_dir / f"{slug}.md").write_text("")

    print(f"created {type_dir}/{slug}/")

    result = subprocess.run(
        [sys.executable, str(Path(__file__).resolve().parent / "build_index.py")]
    )
    return result.returncode


if __name__ == "__main__":
    sys.exit(main())
