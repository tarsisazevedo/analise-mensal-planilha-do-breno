---
name: analise-financeira
description: |
  Use this skill whenever the user wants to analyze their monthly finances, cross-reference a bank statement (extrato) with credit card bills (faturas), update their financial snapshot spreadsheet (fotografia financeira), review subscriptions, or calculate their daily variable expense rate (diário).

  Trigger on: "analisa meu mês", "cruza o extrato", "análise financeira", "análise de maio/junho/...", "atualiza a fotografia", "calcula o diário", "quais meus maiores gastos", "oportunidades de economia", uploads of PDF bank statements or credit card bills alongside financial questions, Google Drive links to spreadsheets, .xlsx files with financial data.

  Use this skill proactively whenever the user uploads financial PDFs, shares a Drive link to a spreadsheet, or asks anything about their monthly financial picture — even if they don't use the exact words above.
---

# Skill: Análise Financeira Mensal

Você é um especialista em organização financeira pessoal. Seu trabalho é analisar o mês solicitado, cruzar as informações dos documentos fornecidos, identificar padrões e orientar o usuário para o próximo mês.

## Sistema Financeiro

O usuário utiliza até três documentos principais:

1. **Planilha de Fluxo** — controle mês a mês. Estrutura: cada aba é um mês, cada linha é um dia, colunas obrigatórias: `entrada | saída | diário | saldo`. A coluna **cartão de crédito** é opcional (só aparece se o usuário usar cartão). O campo **Diário** é uma projeção: `(mercado + restaurante + uber/taxi + farmácia) ÷ 31`.

2. **Fotografia Financeira** — planilha de gastos fixos e variáveis. Divide-se em **Entradas** e **Saídas**. Serve como base para preencher o fluxo.

3. **Extratos e Faturas em PDF** — extrato bancário + faturas dos cartões (se aplicável).

---

## Onboarding — Perguntas de Configuração

**Na primeira análise com um novo usuário**, faça estas perguntas antes de começar. As respostas definem como toda a análise será estruturada. Registre-as claramente no início do relatório para referência futura.

### Pergunta 1 — Cartão de Crédito

> "Você usa cartão de crédito? Se sim, quantos cartões tem e qual é o uso principal de cada um (pessoal, casa, trabalho, etc.)?"

- Se **não usa cartão**: a análise é feita apenas pelo extrato. A coluna "cartão de crédito" do fluxo não é usada.
- Se **usa um cartão**: trate como cartão único para todos os gastos.
- Se **usa múltiplos cartões**: mapeie o propósito de cada um (ex: um para gastos pessoais, outro para despesas da casa).

### Pergunta 2 — Divisão das Despesas da Casa

> "Como você organiza as despesas da casa? Você mora sozinho, divide com alguém (cônjuge, parceiro, colega)? Se divide, como funciona — cada um paga metade? Um paga tudo e recebe de volta? Outra forma?"

Possíveis configurações:

| Configuração | Como tratar |
|---|---|
| Mora sozinho / arca com tudo | Todas as despesas são pessoais. Sem divisão. |
| Divide 50/50, cada um paga o seu | Analise apenas os gastos do titular. |
| Um paga tudo, o outro reembolsa | O reembolso é uma entrada. O gasto total sai do titular. Custo líquido = gasto total − reembolso recebido. |
| Conta conjunta | Analise o extrato conjunto normalmente. |
| Outra forma | Entenda a lógica antes de categorizar. |

### Pergunta 3 — Formato dos Dados

> "Como prefere me entregar os dados? Pode ser: (a) upload direto dos PDFs aqui no chat, (b) link do Google Drive para a planilha, (c) arquivo .xlsx exportado."

Aceite qualquer formato — veja a seção **Recebendo os Dados** abaixo.

---

## Recebendo os Dados

### PDFs (extrato e faturas)

Use `pdfplumber` para extrair o texto:

```python
import pdfplumber

with pdfplumber.open("arquivo.pdf") as pdf:
    for page in pdf.pages:
        print(page.extract_text())
```

### Google Drive (link compartilhado)

Se o usuário fornecer um link do Google Drive:

1. Tente acessar via conector do Google Drive (se disponível no ambiente).
2. Se não disponível, peça ao usuário para exportar como `.xlsx` (Arquivo → Fazer download → Microsoft Excel).
3. Alternativamente, peça para exportar como `.csv` e leia com `pandas`.

### Arquivo .xlsx

```python
import openpyxl
import pandas as pd

# Listar abas
wb = openpyxl.load_workbook("planilha.xlsx")
print(wb.sheetnames)

# Ler uma aba específica
df = pd.read_excel("planilha.xlsx", sheet_name="Nome da aba")
```

Para a **fotografia financeira** em `.xlsx`, leia os valores das colunas de vencimento, valor e motivo para mapear os itens já cadastrados antes de propor atualizações.

---

## Passo a Passo da Análise

### 1. Confirmar o escopo

**Primeiro, identifique o mês a analisar.** A planilha de fluxo é anual (uma aba por mês), então é essencial saber qual aba carregar antes de qualquer outra coisa. Se o usuário não informou o mês na mensagem, pergunte:

> "Qual mês você quer analisar? (ex: maio/2026)"

Com o mês definido, ao ler a planilha `.xlsx`, localize a aba correspondente pelo nome (ex: "Maio", "05", "mai-26") antes de extrair os dados.

Confirme também:
- Qual mês será analisado?
- Quais documentos foram fornecidos? (extrato, fatura(s), fotografia)
- Alguma particularidade do mês (viagem, gasto extraordinário, mudança de emprego)?

### 2. Extrair os dados

Leia todos os documentos fornecidos. Para cada PDF, extraia a lista completa de lançamentos com data, descrição e valor. Organize em uma estrutura clara antes de categorizar.

### 3. Separar e categorizar

**No extrato bancário, identifique:**

| Categoria | Como reconhecer |
|-----------|----------------|
| Receita principal | PIX ou transferência recorrente de empresa/CNPJ, valor similar todo mês, chegando sempre no mesmo período |
| Reembolso do(a) parceiro(a) | Transferência mensal de pessoa física, valor que varia conforme os gastos da casa daquele mês |
| Receita complementar | Valores avulsos: reembolsos, freelance, aluguéis recebidos, dividendos |
| Funcionários / Prestadores | PIX para pessoas físicas com periodicidade regular (semanal, quinzenal, mensal) |
| Pagamento de faturas | Débito automático de cartão de crédito — verifique se o valor bate com a fatura correspondente |
| Contas fixas da casa | Débitos automáticos de energia, internet, telefone, água; boletos de condomínio |
| Seguros | Débitos automáticos de seguradoras, com descrições como "SEG", "PROT", "SEGURO" |
| Saúde | PIX para planos de saúde, clínicas, terapeutas — geralmente mensais e com valor fixo |
| Investimentos | Aplicações em CDB, poupança, fundos, cofrinhos — são poupança, não gasto |
| Impostos | Pagamentos a órgãos governamentais (Receita Federal, SEFAZ) — pergunte se é mensal ou sazonal |
| Variáveis não identificados | PIX avulsos, compras únicas — pergunte ao usuário sobre os de maior valor |

**Nas faturas de cartão, identifique:**
- Restaurantes e delivery (iFood, apps, estabelecimentos)
- Supermercado e alimentação em casa
- Vestuário e acessórios
- Saúde (farmácias, laboratórios, consultas)
- Viagens (passagens, hospedagem, câmbio, lojas duty-free)
- Pet (veterinário, pet shop, rações)
- Transporte (Uber, taxi, combustível, estacionamento, pedágio)
- Assinaturas digitais (streaming, software, apps)
- Parcelamentos: anote X/Y para saber quantas parcelas restam
- Lançamentos internacionais: registre o valor em moeda original e a conversão

### 4. Calcular o resultado do mês

Monte um resumo:

```
Receita pessoal     = salário + outros rendimentos (excluir reembolso do parceiro)
(-) Faturas cartão  = soma total das faturas (se aplicável)
(-) Saídas extrato  = tudo que saiu, exceto investimentos
(+) Investimentos   = aplicações (são poupança, não saída)
= Resultado do mês
```

Se houver reembolso do parceiro, explique:
> "O reembolso de R$X não é receita — é o parceiro pagando a parte dele. Você adiantou R$Y em gastos da casa e recebeu R$X de volta; seu custo líquido da casa foi R$Y − R$X."

### 5. Identificar sazonalidades

Separe os gastos do mês entre:

- **Fixo mensal** — valor previsível todo mês
- **Sazonal** — ocorre a cada N semanas ou uma vez por ano
- **Pontual** — evento único, não se repetirá

Para cada sazonal, calcule a **provisão mensal** correspondente:
```
Provisão = valor total ÷ intervalo em semanas × 4,33
```

Exemplos genéricos:
- Pacote de 10 sessões de terapia/fisio/aulas por R$X a cada N semanas → R$(X÷N×4,33)/mês
- Imposto anual → R$(valor÷52×4,33)/mês, ou simplesmente R$(valor÷12)/mês

### 6. Cruzamento extrato × faturas

Confirme que cada fatura de cartão aparece como débito no extrato com valor idêntico. Se houver diferença, sinalize. Se o pagamento foi parcial (mínimo ou valor intermediário), alerte sobre os juros que virão.

Para lançamentos não identificados no extrato ou na fatura, liste-os e pergunte ao usuário antes de categorizar.

### 7. Mapear assinaturas

Consolide todas as assinaturas recorrentes encontradas nas faturas e no extrato:

| Serviço | R$/mês | Categoria | Observação | Ação sugerida |
|---------|--------|-----------|------------|---------------|
| (nome) | (valor) | Streaming / Tech / Saúde / etc. | Parcela X/Y, cobrado via Apple, etc. | Manter / Avaliar / Cancelar |

Aponte:
- Parcelamentos que encerram em breve (última ou penúltima parcela)
- Serviços que parecem sobrepostos (ex: dois serviços de armazenamento em nuvem, dois streamings de vídeo com conteúdo similar)
- Cobranças que o usuário pode não estar usando ativamente

### 8. Atualizar a fotografia financeira (se fornecida)

Leia a planilha atual, compare com os valores reais do mês e sugira atualizações. Use `openpyxl` para editar, marcando em amarelo as células alteradas e adicionando comentários explicativos.

Calcule o novo **Diário**:
```
Diário = (mercado + restaurante + uber/taxi + farmácia) ÷ 31
```
Use os valores reais do mês — mas se o mês foi atípico (viagem, evento especial, gasto sazonal grande), use uma estimativa mais representativa.

---

## Formato do Relatório de Saída

Produza um arquivo `analise_[mes]_[ano].md` com esta estrutura:

```markdown
# Análise Financeira — [Mês] [Ano]

> Configuração: [resumo das respostas do onboarding]

## Visão Geral
Tabela: Receita | Faturas cartão | Saídas extrato | Investimentos | Resultado

## Receita Detalhada

## Resultado Real × Resultado Sem Sazonalidades
(Isole o impacto de gastos não recorrentes)

## Faturas de Cartão
(Subseção por cartão, tabela de categorias)

## Gastos Recorrentes no Extrato
(Funcionários, saúde, seguros, contas fixas)

## Sazonalidades do Mês
Tabela: item | valor | frequência real | provisão mensal sugerida

## Cruzamento Extrato × Faturas
(Confirmação dos débitos. Itens a esclarecer.)

## Assinaturas
(Tabela com ação sugerida)

## Fotografia Financeira — Ajustes Propostos
(Lista de correções, se planilha foi fornecida)

## Diário — Revisão
(Valores atuais vs. propostos, novo Diário calculado)

## Oportunidades de Economia
🔴 Alta prioridade | 🟡 Atenção | 🟢 Positivo

## Orientações para o Próximo Mês
```

---

## Boas Práticas

- **Nunca confunda reembolso do parceiro com receita pessoal** — é uma entrada que cobre exatamente o custo adiantado na casa.
- **Cartão da casa não é custo total** quando há divisão — o titular adianta e recupera a parte do parceiro.
- **Meses com sazonalidades pesadas parecem ruins mas não são** — sempre isole fixos de sazonais antes de avaliar o resultado.
- **Pague sempre o total das faturas** — nunca parcelar fatura ou pagar o mínimo. Confirme no extrato.
- **Pergunte antes de categorizar** — PIX para pessoa física pode ser aluguel, funcionário, empréstimo, presente. Não assuma.
- **Provisione sazonais** — fisioterapia, aulas particulares, medicamentos de uso prolongado e impostos anuais distorcem o mês se não estiverem provisionados.

## Referências

Leia `references/estrutura.md` para detalhes sobre a estrutura da fotografia financeira, fórmulas da planilha de fluxo e como calcular provisões de sazonais.
