import os
import hashlib
import base64
import string
import sys

def string_pbkdf2_encrypt(pwd: string):
    salt = os.urandom(32)
    key = hashlib.pbkdf2_hmac('sha512',pwd.encode('utf-8'), salt, 100000)
    storage = base64.b64encode(salt) + bytes(':', 'utf8') + base64.b64encode(key)
    return storage.decode('utf8')

def main():
    string_to_encrypt = sys.argv[1]
    print(string_pbkdf2_encrypt(string_to_encrypt))

if __name__ == "__main__":
    main()