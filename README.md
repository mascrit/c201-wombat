# c201-wombat - CompiladorWombat

### Integrantes

- Romero Andrade Cristian
- Rocha García Erick Hazel
- Arguelles Macosay Mariana


## Ejecución

ejecutar:

```zsh
> make
```

para probar

```zsh
> ./compiladorwombat archivo.c
```

limpiar binario

```zsh
make clean
```

**TODO: Add description**

## Installation


```elixir
def deps do
  [
    {:compilador_wombat, "~> 0.1.0"}
  ]
end
```

## Estructura

Como se está utilizando el manejador de proyectos *mix*,
el código en elixir se pondrá en la carpeta **lib**, ya sea
la siguiente estructura en *lib*:

```bash
lib
├── compiladorwombat.ex
└── wc2
    ├── analizador.ex
    ├── lexer.ex
    └── otroArchivo.ex
	
```

Los archivos como el Lexer, el parcer u lo que sea que le dan sentido
al proyecto deben estar en `lib/wc2` y el "main" del proyecto es
`lib/compiladorwombat.ex`. Toda Documentación se hará en este README.md,
si en el caso de documentar módulo hacerlo en sus repectivos archivos
siguiendo el "estandar" de documentación de elixir.

Cualquier duda sobre lo que dije ver el tutorial de elixirschool[^1].


Documentacion generada por [ExDoc](https://github.com/elixir-lang/ex_doc)

[^1]: https://elixirschool.com/es/
