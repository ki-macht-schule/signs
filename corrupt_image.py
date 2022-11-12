import argparse
import pathlib

import numpy as np
import PIL.Image
import imagecorruptions

parser = argparse.ArgumentParser()
parser.add_argument("--corruption", choices = imagecorruptions.get_corruption_names())
parser.add_argument("--severity", choices = list(range(1,6)), type = int)
args = parser.parse_args()

for image in pathlib.Path("img").glob("*.png"):
    if "-" in str(image):
        continue
    output = image.parent / f"{image.name}-{args.corruption}-{args.severity}.png"

    image = np.array(PIL.Image.open(image))
    corrupted = imagecorruptions.corrupt(image, corruption_name=args.corruption, severity=args.severity)
    corrupted = PIL.Image.fromarray(corrupted)
    corrupted.save(output)
    
    print(output)
