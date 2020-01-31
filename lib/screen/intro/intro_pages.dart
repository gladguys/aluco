import 'package:aluco/screen/intro/profile_image_picker.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

final initialPage = PageViewModel(
  image: Padding(
    padding: const EdgeInsets.fromLTRB(16, 56, 16, 16),
    child: Material(
      elevation: 4,
      clipBehavior: Clip.antiAlias,
      borderRadius: BorderRadius.circular(16),
      child: Image.asset(
        'assets/images/alunos_sliver.jpeg',
        fit: BoxFit.cover,
      ),
    ),
  ),
  title: '',
  bodyWidget: Center(
    child: Text(
      'Gerencie suas turmas com praticidade e simplicidade!',
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 24),
    ),
  ),
);

final profilePhotoPage = PageViewModel(
  image: Padding(
    padding: const EdgeInsets.fromLTRB(16, 56, 16, 16),
    child: Material(
      elevation: 4,
      clipBehavior: Clip.antiAlias,
      borderRadius: BorderRadius.circular(16),
      child: Image.asset(
        'assets/images/alunos_chairs_sliver.jpeg',
        fit: BoxFit.cover,
      ),
    ),
  ),
  title: '',
  bodyWidget: Center(
    child: Text(
      'Adicione suas turmas, vincule os respectivos alunos, realize as chamadas diárias e as provas da turma...',
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 24),
    ),
  ),
);

final helperPage = PageViewModel(
  image: Padding(
    padding: const EdgeInsets.fromLTRB(16, 56, 16, 16),
    child: Material(
      elevation: 4,
      clipBehavior: Clip.antiAlias,
      borderRadius: BorderRadius.circular(16),
      child: Image.asset(
        'assets/images/turma_sliver.jpeg',
        fit: BoxFit.cover,
      ),
    ),
  ),
  title: '',
  bodyWidget: Center(
    child: Text(
      'Envie relatórios para a coordenação da sua escola sempre que necessário!',
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 24),
    ),
  ),
);

final userPhotoPage = PageViewModel(
  image: Padding(
    padding: const EdgeInsets.fromLTRB(16, 56, 16, 16),
    child: Material(
      color: Colors.grey[200],
      elevation: 4,
      clipBehavior: Clip.antiAlias,
      borderRadius: BorderRadius.circular(16),
      child: ProfileImagePicker(),
    ),
  ),
  title: '',
  bodyWidget: Center(
    child: Text(
      'Quase tudo pronto. Se você quiser, toque no card acima para tirar uma foto da sua câmera para usarmos como foto do seu perfil.',
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 24),
    ),
  ),
);

final pages = [initialPage, profilePhotoPage, helperPage, userPhotoPage];
