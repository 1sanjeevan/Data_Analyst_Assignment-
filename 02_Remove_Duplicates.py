def remove_duplicates(input_string):
    unique_string = ""
    for char in input_string:
        if char not in unique_string:
            unique_string += char
    return unique_string

print(remove_duplicates("programming"))
print(remove_duplicates("hello"))
print(remove_duplicates("aabbcc"))
