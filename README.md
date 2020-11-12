# testApp

A new Flutter project.

## Getting Started

## Build data classes

Afin de build les data class, il faut run cette commande:
```
flutter packages pub run build_runner build
```
Cette commande va générer les méthodes **toJson** et **fromJson** de chacune des classes avec l'annotation **@JsonSerializable**