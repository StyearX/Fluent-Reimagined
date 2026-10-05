import os
import re

Root = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
OrderFile = os.path.join(Root, "Build", "Order.txt")
Output = os.path.join(Root, "dist", "Main.lua")
ServicePattern = re.compile(r'^local (\w+): \1 = cloneref\(game:GetService\("\1"\)\)$')

with open(OrderFile) as File:
    Paths = [Line.strip() for Line in File if Line.strip()]

Seen = set()
Parts = []
for Path in Paths:
    with open(os.path.join(Root, Path)) as File:
        Lines = File.read().split("\n")

    Index = 0
    Kept = []
    while Index < len(Lines):
        Match = ServicePattern.match(Lines[Index])
        if not Match:
            break
        if Match.group(1) not in Seen:
            Seen.add(Match.group(1))
            Kept.append(Lines[Index])
        Index += 1

    if Index > 0:
        if Index < len(Lines) and Lines[Index] == "":
            Index += 1
            if Kept:
                Kept.append("")
        Lines = Kept + Lines[Index:]

    for Line in Lines:
        Match = ServicePattern.match(Line)
        if Match:
            Seen.add(Match.group(1))

    Parts.append("\n".join(Lines))

os.makedirs(os.path.dirname(Output), exist_ok=True)
with open(Output, "w") as File:
    File.write("".join(Parts))

print("Built", Output, len(Paths), "files")
