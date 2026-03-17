# SQLgard - RPG Engine

Projeto desenvolvido para o Checkpoint de **Mastering Relational and Non-Relational Database**.

## Sobre o projeto

O projeto **SQLgard - RPG Engine** simula um motor de batalha simples em um universo de RPG.  
Uma névoa venenosa atinge todos os heróis ativos a cada turno, reduzindo seu HP. Quando o HP de um herói chega a zero, seu status é alterado para **CAÍDO**.

A interface web foi construída com **Flask**, enquanto toda a lógica principal de processamento foi implementada em **Oracle PL/SQL**, conforme exigido no checkpoint.

---

## Objetivo do checkpoint

O objetivo é demonstrar a integração entre:

- **Python + Flask** para interface web
- **Oracle Database** para persistência dos dados
- **PL/SQL** para a lógica de negócio principal

O sistema permite:

- listar os heróis cadastrados
- visualizar HP atual e HP máximo
- avançar turnos com o botão **Próximo Turno**
- processar o dano da névoa diretamente no banco de dados
- atualizar o status dos heróis para **CAÍDO** quando o HP chegar a zero

---

## Tecnologias utilizadas

- Python
- Flask
- Oracle Database
- Oracle PL/SQL
- HTML
- CSS
- Vercel

---

## Estrutura do projeto

```bash
cp1-mastering-database/
├─ api/
│  └─ app.py
├─ sql/
│  ├─ init.sql
│  └─ turno_nevoa.sql
├─ templates/
│  └─ index.html
├─ requirements.txt
├─ vercel.json
└─ README.md
```

### Descrição dos arquivos

- `api/app.py`  
  Responsável pela aplicação Flask, conexão com o banco, listagem dos heróis e execução do bloco PL/SQL.

- `sql/init.sql`  
  Script de criação da tabela `TB_HEROIS` e inserção dos dados iniciais.

- `sql/turno_nevoa.sql`  
  Bloco PL/SQL responsável por processar o turno da névoa, atualizar o HP dos heróis e alterar o status para `CAÍDO` quando necessário.

- `templates/index.html`  
  Interface web para exibir os heróis e acionar o botão de próximo turno.

- `requirements.txt`  
  Dependências do projeto.

- `vercel.json`  
  Configuração de deploy na Vercel.

---

## Modelo de dados

A tabela principal do projeto é:

### `TB_HEROIS`

| Campo      | Tipo         | Descrição |
|-----------|--------------|-----------|
| id_heroi  | NUMBER       | Identificador do herói |
| nome      | VARCHAR2(50) | Nome do herói |
| classe    | VARCHAR2(20) | Classe do herói |
| hp_atual  | NUMBER       | Vida atual do herói |
| hp_max    | NUMBER       | Vida máxima do herói |
| status    | VARCHAR2(20) | Status do herói (`ATIVO` ou `CAÍDO`) |

---

## Regras de negócio

A lógica principal do sistema acontece no Oracle, através de um bloco PL/SQL.

### Regras implementadas

- a névoa causa dano fixo por turno
- apenas heróis com status `ATIVO` são processados
- o processamento percorre todos os heróis ativos com **Cursor**
- a repetição é feita com **Loop**
- o HP é atualizado a cada turno
- quando o HP chega a zero, o herói passa para status `CAÍDO`
- o HP não pode ficar negativo

---

## Como executar localmente

### 1. Criar a tabela e inserir os dados
Executar o arquivo:

```sql
sql/init.sql
```

### 2. Instalar as dependências
```bash
pip install -r requirements.txt
```

### 3. Definir as variáveis de ambiente

No terminal, defina:

- `DB_USER`
- `DB_PASSWORD`
- `DB_DSN`

Exemplo no PowerShell:

```powershell
$env:DB_USER="seu_usuario"
$env:DB_PASSWORD="sua_senha"
$env:DB_DSN="oracle.fiap.com.br:1521/orcl"
python api/app.py
```

### 4. Acessar no navegador
```txt
http://127.0.0.1:5000
```

---

## Deploy

O projeto foi preparado para deploy na **Vercel**.

### Variáveis de ambiente na Vercel

Cadastrar no painel do projeto:

- `DB_USER`
- `DB_PASSWORD`
- `DB_DSN`

---

## Funcionamento da aplicação

1. O usuário acessa a interface web.
2. Os heróis são listados com seus respectivos atributos.
3. Ao clicar em **Próximo Turno**, a aplicação Flask executa o bloco PL/SQL no Oracle.
4. O banco processa o dano da névoa.
5. O HP dos heróis é atualizado.
6. Caso o HP chegue a zero, o status muda para **CAÍDO**.
7. A tela é recarregada com os novos dados.

---

## Participação dos integrantes

### Matheus
Responsável pela estrutura principal da lógica em PL/SQL, incluindo:

- criação da tabela de heróis
- inserção dos dados iniciais
- desenvolvimento do bloco anônimo base
- declaração de variáveis de controle
- criação do cursor para seleção dos heróis ativos
- uso de loop para percorrer os registros
- cálculo do dano da névoa
- atualização inicial do HP dos heróis
- organização da base do projeto

### Ana
Responsável pelo refinamento da lógica em PL/SQL e finalização da regra de negócio, incluindo:

- tratamento para impedir HP negativo
- atualização do status para `CAÍDO`
- contagem de heróis derrotados
- refinamento do processamento por turno
- validação dos cenários de execução
- apoio na integração final com a interface Flask

---

## Integrantes

- **Matheus Moya de Oliveira**
- **Ana Carolina Pereira Fontes**

---

## Observações finais

Este projeto foi desenvolvido com foco na avaliação da lógica de banco de dados, utilizando **PL/SQL** como núcleo do processamento, enquanto o Flask foi utilizado como interface simples para interação via web.
