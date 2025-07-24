import os
from PIL import Image

def convert_green_to_transparent(folder_path):
    for filename in os.listdir(folder_path):
        if filename.lower().endswith('.png'):
            image_path = os.path.join(folder_path, filename)
            image = Image.open(image_path).convert('RGBA')
            data = image.getdata()

            new_data = []
            for item in data:
                # If pure green, make transparent
                if item[0] == 0 and item[1] == 255 and item[2] == 0:
                    new_data.append((0, 0, 0, 0))  # Fully transparent
                else:
                    new_data.append(item)

            image.putdata(new_data)
            image.save(image_path)  # Overwrites the original image
            print(f"Processed: {filename}")

# 🔧 Set your folder path here
folder = "player"
convert_green_to_transparent(folder)
