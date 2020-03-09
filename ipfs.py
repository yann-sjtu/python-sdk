
import ipfsapi
import os

usage = '''
Usage:
    1.Upload file
    2.View file
    3.Download file
    4.All file keys
    5.Quit
'''


if __name__ == "__main__":
    try:
        ipfs_api = ipfsapi.connect('127.0.0.1', 5001)
        print(usage)
        while True:
            choice = input("input a number: ")
            if choice == '1':
                file_name = input("Enter file name with full path: ")
                new_file = ipfs_api.add(file_name)
                print("file hash:", new_file['Hash'])

            elif choice == '2':
                key = input("Please enter file hash : ")
                res = ipfs_api.cat(key)
                print("The file content is:", res)
            
            elif choice == '3':
                key = input("Please enter file hash : ")
                ipfs_api.get(key)
                print("File with hash " + str(key) + " is downloaded to current directory.")
            elif choice == '4':
                res = ipfs_api.pin.ls(type='all')
                print(res)
            else:
                print("bye~")
                break

    except ipfsapi.exceptions.ConnectionError as ce:
        print(str(ce))
