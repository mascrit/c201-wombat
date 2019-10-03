from cwombat.Cli import Cli


if __name__ == '__main__':
    consola = Cli()
    mes, code = consola.evaluar_args()
    print(mes)
    exit(code)
