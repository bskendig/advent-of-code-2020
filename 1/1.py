#!/usr/bin/python3

def file_read_array(fname):
    content_array = []
    with open(fname) as f:
        for line in f:
            content_array.append(int(line))
    return content_array

lines = file_read_array('input')

for i in range(len(lines)):
    first = lines[i]
    for second in lines[i:]:
        if first + second == 2020:
            print(first * second)
            break

for i in range(len(lines)):
    first = lines[i]
    for j in range(i+1, len(lines)):
        second = lines[j]
        for k in range(j+1, len(lines)):
            third = lines[k]
            if first + second + third == 2020:
                print(first * second * third)
                break
