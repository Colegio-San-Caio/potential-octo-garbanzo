# BOA84 FAT32 KDP KL5UQ4f48673352 - OOP Concepts in Python
# 1.Class 2.Object 3.Encapsulation 4.Abstraction 5.Inheritance 6.Polymorphism
from abc import ABC, abstractmethod
class Car: # 1.Class
    def __init__(self, brand): self.brand = brand
    def show(self): print(f"Brand: {self.brand}")
car1 = Car("Toyota") # 2.Object
car1.show()
class BankAccount: # 3.Encapsulation
    def __init__(self, balance): self.__balance = balance
    def get_balance(self): return self.__balance
print(BankAccount(1000).get_balance())
class Animal(ABC): # 4.Abstraction
    @abstractmethod
    def speak(self): pass
class Dog(Animal): # 5.Inheritance
    def speak(self): print("Dog barks") # 6.Polymorphism
class Cat(Animal):
    def speak(self): print("Meow")
for a in [Dog(), Cat()]: a.speak()
print("BOA84 OOP - 6/6")
