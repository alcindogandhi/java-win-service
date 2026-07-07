# java-win-service

Exemplo de serviço para MS Windows em Java.

## Descrição

Este projeto é um exemplo de serviço para MS Windows feito em Java. Ele utiliza o `Procrun` do projeto [Apache Commons Daemon](https://commons.apache.org/proper/commons-daemon/) para criar o referido serviço.

O programa `procrun.exe` foi renomeado para `java-win-service.exe` e ele é oriundo da versão 1.6.1 da biblioteca de origem.

O serviço em si apenas imprime uma mensagem a cada 5 segundos indicando que o serviço está em execução.

## Requisitos

- **Java Development Kit (JDK)**: Versão 8 ou superior
- **Maven**: Versão 3.6 ou superior
- **Windows**: Sistema operacional Windows (7, 8, 10, 11 ou Server)
- **Direitos de Administrador**: Necessário para instalar/desinstalar o serviço

## Estrutura do Projeto

```
java-win-service/
├── pom.xml                          # Arquivo de configuração Maven
├── README.md                        # Este arquivo
├── LICENSE                          # Licença do projeto
├── tasks.md                         # Tarefas do projeto
├── install.cmd                      # Script para instalar o serviço
├── uninstall.cmd                    # Script para desinstalar o serviço
├── update.cmd                       # Script para atualizar o serviço
├── java-win-service.exe             # Executável do Procrun
└── src/
    └── main/java/br/gov/mg/fazenda/
        ├── Log.java                 # Classe utilitária para logging
        └── MainService.java         # Classe principal do serviço
```

## Compilação

Para compilar o projeto, execute:

```bash
mvn clean compile
```

Para gerar o artefato JAR:

```bash
mvn clean package
```

## Descrição das Classes

### Log.java

Classe utilitária que fornece métodos estáticos para logging com timestamp. Registra mensagens de informação (INFO) no stdout e mensagens de erro (ERROR) no stderr.

**Métodos:**
- `info(String msg)`: Registra uma mensagem de informação com timestamp
- `error(String msg)`: Registra uma mensagem de erro com timestamp

### MainService.java

Classe principal que implementa a lógica do serviço Windows. Gerencia o ciclo de vida da aplicação em uma thread separada, registrando mensagens de status a cada 5 segundos.

**Métodos:**
- `start(String[] args)`: Inicia o serviço em uma thread separada
- `stop(String[] args)`: Para o serviço de forma graciosa
- `main(String[] args)`: Ponto de entrada da aplicação

## Instalação e Desinstalação

### Instalação

1. Abra o Prompt de Comando (CMD) como **Administrador**
2. Navegue até o diretório do projeto
3. Execute o script de instalação:

```cmd
install.cmd
```

O script criará o serviço Windows com o nome "java-win-service".

### Iniciar o Serviço

Após a instalação, o serviço pode ser iniciado com:

```cmd
net start java-win-service
```

Ou através do Gerenciador de Serviços do Windows.

### Parar o Serviço

Para parar o serviço:

```cmd
net stop java-win-service
```

### Atualizar o Serviço

Se fizer alterações no código, compile novamente e execute:

```cmd
update.cmd
```

### Desinstalação

Para remover o serviço do Windows:

1. Abra o Prompt de Comando como **Administrador**
2. Navegue até o diretório do projeto
3. Execute o script de desinstalação:

```cmd
uninstall.cmd
```

## Verificação do Status

Para verificar o status do serviço:

```cmd
net start
```

Procure por "java-win-service" na lista de serviços ativos.

## Logs

O serviço registra suas mensagens no console com timestamp no formato `yyyy-MM-dd HH:mm:ss.SSS`. Para visualizar os logs, você pode:

1. Verificar o Gerenciador de Eventos do Windows (Event Viewer)
2. Redirecionar a saída padrão para um arquivo (através do Procrun)

## Troubleshooting

### O serviço não inicia
- Verifique se o Java está instalado e acessível no PATH do Windows
- Verifique se possui direitos de administrador
- Consulte o Gerenciador de Eventos do Windows para detalhes de erro

### Erro de permissão
- Certifique-se de executar os scripts CMD como Administrador
- Verifique as permissões da pasta do projeto

### Serviço travado
- Interrompa o serviço com `net stop java-win-service`
- Aguarde alguns segundos e reinicie com `net start java-win-service`

## Licença

Este projeto está licenciado sob os termos da licença MIT especificada no arquivo [LICENSE](LICENSE).
