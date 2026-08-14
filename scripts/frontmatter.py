"""Minimal frontmatter parser/serializer shared by build_index.py and new_piece.py.

Only supports a flat block of `key: value` string pairs between two `---`
lines — no nested structures, no YAML types. That's all a notes.md file
in the type/slug/notes.md document-repo convention needs.
"""

FIELD_ORDER = ["title", "status", "description"]


class FrontmatterError(ValueError):
    pass


def parse(text):
    """Parse `text` into (fields dict, body str). Raises FrontmatterError."""
    lines = text.splitlines()
    if not lines or lines[0].strip() != "---":
        raise FrontmatterError("missing opening '---' frontmatter delimiter")

    fields = {}
    i = 1
    while i < len(lines) and lines[i].strip() != "---":
        line = lines[i]
        if not line.strip():
            i += 1
            continue
        if ":" not in line:
            raise FrontmatterError(f"malformed frontmatter line: {line!r}")
        key, _, value = line.partition(":")
        fields[key.strip()] = value.strip()
        i += 1

    if i >= len(lines):
        raise FrontmatterError("missing closing '---' frontmatter delimiter")

    body = "\n".join(lines[i + 1 :]).lstrip("\n")
    return fields, body


def render(fields, body=""):
    """Serialize `fields` (dict) and `body` (str) back into notes.md text."""
    ordered_keys = [k for k in FIELD_ORDER if k in fields]
    ordered_keys += [k for k in fields if k not in FIELD_ORDER]

    lines = ["---"]
    for key in ordered_keys:
        lines.append(f"{key}: {fields[key]}")
    lines.append("---")

    text = "\n".join(lines) + "\n"
    if body:
        text += "\n" + body if not body.startswith("\n") else body
        if not text.endswith("\n"):
            text += "\n"
    return text
