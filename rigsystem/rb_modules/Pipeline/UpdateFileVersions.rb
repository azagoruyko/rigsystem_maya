<module name="UpdateFileVersions" muted="0" uid="8fcc38bea4c04a68aa0119896f4572c2">
<run><![CDATA[import os
import re
import pymel.core as pm

updated_count = 0
for node in pm.ls(type="file"):
    path = node.fileTextureName.get()
    filename = os.path.basename(path)
    stem = os.path.splitext(filename)[0]
    numbers = list(re.finditer(r"\d+", stem))
    if not numbers:
        continue

    version = numbers[-1]
    prefix = filename[:version.start()]
    suffix = filename[version.end():]
    latest_number = int(version.group())
    latest_name = filename

    expanded_path = os.path.expanduser(os.path.expandvars(path))
    directory = os.path.dirname(pm.workspace(expandName=expanded_path))
    if not os.path.isdir(directory):
        warning("{}: directory does not exist: {}".format(node, directory))
        continue

    candidate_pattern = re.compile(re.escape(prefix) + r"(\d+)" + re.escape(suffix))
    with os.scandir(directory) as entries:
        for entry in entries:
            if not entry.is_file():
                continue

            candidate = candidate_pattern.fullmatch(entry.name)
            if candidate and int(candidate.group(1)) > latest_number:
                latest_number = int(candidate.group(1))
                latest_name = entry.name

    if latest_name != filename:
        new_path = path[:-len(filename)] + latest_name
        node.fileTextureName.set(new_path)
        print("{}: {} -> {}".format(node, path, new_path))
        updated_count += 1

print("Updated {} file node(s).".format(updated_count))]]></run>
<doc><![CDATA[## Summary
Updates Maya `file` nodes to the highest numbered matching file in each node's current directory. It finds the last group of digits before the file extension automatically.

## Inputs
No settings are required. The module reads the `fileTextureName` path from every Maya `file` node.

## Outputs
Prints each changed node and its old/new path, followed by the number of updated nodes.

## Usage
Run in Maya to scan all `file` nodes. For example, `file.001.jpg` becomes `file.005.jpg` when `file.005.jpg` is the highest matching file in the folder. Names such as `file_v001_diffuse.jpg` also work. Text before and after the number must match exactly. If a filename has several number groups, the last one before its extension is treated as the version. Nodes without a number or newer matching file are left unchanged.]]></doc>
</module>