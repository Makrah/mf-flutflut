# mappin

## Getting Started

Voici l'url du projet: https://github.com/Makrah/mf-flutflut.git

Tout d'abord vous devez cloner le projet dans votre local. Dans votre terminal run:
```
git clone https://github.com/Makrah/mf-flutflut.git
```

Afin d'installer flutter, vous pouvez suivre le tutoriel officiel:
https://flutter.dev/docs/get-started/install

Une fois flutter installé, il faut run cette commande afin d'installer les différentes librairies:
```
flutter pub get
```

Vous pouvez ensuite lancer un simulateur ou connecter votre téléphone pour run l'application.
Une fois connecté, il faut run la commande:
```
flutter run
```

## Build data classes

Afin de build les data class, il faut run cette commande:

```
flutter packages pub run build_runner build --delete-conflicting-outputs
```

Cette commande va générer les méthodes **toJson** et **fromJson** de chacune des classes avec l'annotation **@JsonSerializable**
