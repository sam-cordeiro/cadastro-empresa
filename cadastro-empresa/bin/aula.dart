import 'dart:io';

class Funcionario {
  late int _id;
  late String _nome;
  late String _cargo;
  late double _salario;

  Funcionario(this._id, this._nome, this._cargo, this._salario);

  int get id => _id;
  String get nome => _nome;
  String get cargo => _cargo;
  double get salario => _salario;

  void exibirInformacoes() {
    print('ID: $_id, Nome: $_nome, Cargo: $_cargo, Salário: $_salario');
  }
}

class Empresa {
  late int id;
  late String nome;
  List<Funcionario> listaFuncionarios = [];

  static int _proximoIdEmpresa = 1;
  static int _proximoIdFuncionario = 1;

  void adicionarFuncionario(String nome, String cargo, double salario) {
    Funcionario novoFuncionario = Funcionario(_proximoIdFuncionario, nome, cargo, salario);
    listaFuncionarios.add(novoFuncionario);
    _proximoIdFuncionario++;
  }

  void exibirInformacoesEmpresa() {
    print('ID da Empresa: $id');
    print('Nome da Empresa: $nome');
  }

  void exibirInformacoesFuncionarios() {
    if (listaFuncionarios.isEmpty) {
      print("Nenhum funcionário cadastrado.");
    } else {
      for (var funcionario in listaFuncionarios) {
        funcionario.exibirInformacoes();
      }
    }
  }

  static Empresa criarNovaEmpresa(String nome) {
    Empresa novaEmpresa = Empresa();
    novaEmpresa.id = _proximoIdEmpresa;
    novaEmpresa.nome = nome;
    _proximoIdEmpresa++;
    return novaEmpresa;
  }
}

void main() {
  List<Empresa> listaEmpresas = [];
  Empresa? empresaSelecionada;

  while (true) {
    print("\nEscolha uma ação:");
    print("1. Cadastrar Empresa");
    print("2. Cadastrar Funcionário");
    print("3. Exibir Informações da Empresa");
    print("4. Exibir Informações dos Funcionários");
    print("5. Sair");

    String escolha = stdin.readLineSync()!;

    switch (escolha) {
      case '1':
        print("Digite o nome da empresa:");
        String nomeEmpresa = stdin.readLineSync()!;

        Empresa novaEmpresa = Empresa.criarNovaEmpresa(nomeEmpresa);
        listaEmpresas.add(novaEmpresa);

        print("Empresa cadastrada com sucesso!");
        break;

      case '2':
        if (listaEmpresas.isEmpty) {
          print("Você precisa cadastrar uma empresa primeiro.");
        } else {
          print("Escolha a empresa para cadastrar o funcionário:");
          for (var i = 0; i < listaEmpresas.length; i++) {
            print("${i + 1}. ${listaEmpresas[i].nome}");
          }

          int escolhaEmpresa = int.parse(stdin.readLineSync()!);
          empresaSelecionada = listaEmpresas[escolhaEmpresa - 1];

          print("Digite o nome do funcionário:");
          String nomeFuncionario = stdin.readLineSync()!;

          print("Digite o cargo do funcionário:");
          String cargoFuncionario = stdin.readLineSync()!;

          print("Digite o salário do funcionário:");
          double salarioFuncionario = double.parse(stdin.readLineSync()!);

          empresaSelecionada.adicionarFuncionario(nomeFuncionario, cargoFuncionario, salarioFuncionario);

          print("Funcionário cadastrado com sucesso!");
        }
        break;

      case '3':
        if (listaEmpresas.isEmpty) {
          print("Nenhuma empresa cadastrada.");
        } else {
          print("Escolha a empresa para exibir as informações:");
          for (var i = 0; i < listaEmpresas.length; i++) {
            print("${i + 1}. ${listaEmpresas[i].nome}");
          }

          int escolhaEmpresa = int.parse(stdin.readLineSync()!);
          empresaSelecionada = listaEmpresas[escolhaEmpresa - 1];

          print("\nInformações da Empresa:");
          empresaSelecionada.exibirInformacoesEmpresa();
        }
        break;

      case '4':
        if (listaEmpresas.isEmpty) {
          print("Nenhuma empresa cadastrada.");
        } else {
          print("Escolha a empresa para exibir os funcionários:");
          for (var i = 0; i < listaEmpresas.length; i++) {
            print("${i + 1}. ${listaEmpresas[i].nome}");
          }

          int escolhaEmpresa = int.parse(stdin.readLineSync()!);
          empresaSelecionada = listaEmpresas[escolhaEmpresa - 1];

          print("\nInformações dos Funcionários:");
          empresaSelecionada.exibirInformacoesFuncionarios();
        }
        break;

      case '5':
        print("Saindo...");
        return;

      default:
        print("Opção inválida. Tente novamente.");
    }
  }
}
