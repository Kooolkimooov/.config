from glob import glob
from os import getcwd

if __name__ == "__main__":
    
    directory = getcwd()
    files = glob("./*")

    with open("./list.txt", "w") as output_file: 
        for file in files:
            if file.split('.')[-1] in ["py", "txt"]: continue
            output_file.write(f'{directory}/{file[2:]}\n')
