#!/sbin/python

def ins(existing, newitems):
    existing += newitems
    existing.sort()
    return existing


def getnewnames():
    print("enter usernames (Q to finish):")
    choice = input()
    names = []
    while choice.upper() != "Q":
        names.append(choice)
        choice = input()
    return names


def lsflist2list(lsflist):
    lsflist = lsflist.split(" ")
    lsflist = lsflist[1:-1]
    return lsflist


def list2lsflist(lst):
    output = "( "
    for i in lst:
        output += f"{i} "
    output += ")"
    return output


oldlist = input("enter existing list in ( usr1 usr2 usr3 ) format:\n")
oldlist = lsflist2list(oldlist)

additions = getnewnames()

newlist = ins(oldlist, additions)

newlistformatted = list2lsflist(newlist)

print(newlistformatted)