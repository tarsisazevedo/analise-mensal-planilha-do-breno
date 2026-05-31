# Estrutura Detalhada — Fotografia Financeira e Planilha de Fluxo

## Planilha de Fluxo

Cada aba representa um mês. Colunas por linha (dia):

| Coluna | Obrigatória | Descrição |
|--------|-------------|-----------|
| Entrada | Sim | Receitas do dia (salário, reembolsos, rendimentos) |
| Saída | Sim | Gastos diretos (PIX, boletos, débitos automáticos) |
| Diário | Sim | Projeção diária das categorias variáveis: `(mercado + restaurante + uber + farmácia) ÷ 31` |
| Cartão de Crédito | **Opcional** | Fatura(s) do cartão quando vencer. Só usar se o usuário tiver cartão. |
| Saldo | Sim | Saldo da conta ao final do dia |

O **Diário** é lançado todos os dias como estimativa de consumo variável. No fechamento do mês, compara-se o previsto com o realizado.

---

## Fotografia Financeira

### Entradas

| Vencimento | Valor | Motivo |
|------------|-------|--------|
| Dia fixo | Salário / honorários / renda principal | — |
| Dia variável | Reembolso do parceiro (se houver divisão de casa) | Calculado conforme acordo entre as partes |
| Outros | Aluguéis recebidos, dividendos, freelance recorrente | — |

### Configurações de divisão de casa

A forma como o reembolso do parceiro é calculado depende do acordo de cada família. Exemplos comuns:

**Divisão 50/50 com cartão compartilhado:**
```
Reembolso = (gastos em dinheiro da casa + fatura do cartão da casa) ÷ 2
```

**Divisão proporcional (ex: 60/40):**
```
Reembolso = total das despesas da casa × percentual do parceiro
```

**Cada um paga categorias específicas:**
Não há reembolso — cada um tem suas próprias contas.

**Apenas um paga tudo:**
Sem divisão, sem reembolso. Todos os gastos são do titular.

### Saídas — Fixos

Gastos com valor previsível todo mês:

- Aluguel / condomínio / financiamento imobiliário
- Energia elétrica, água, gás
- Internet e telefone
- Seguros (vida, imóvel, veículo, saúde)
- Funcionários domésticos (diarista, cozinheira, motorista, etc.)
- Prestadores recorrentes (fisioterapeuta, professor, personal trainer)
- Plano de saúde
- Mensalidades de academia / escola / cursos
- Assinaturas digitais recorrentes

### Saídas — Variáveis (entram no Diário)

- **Mercado** — supermercado, padaria, alimentação preparada em casa, compras feitas por funcionários domésticos com reembolso
- **Restaurante** — alimentação fora de casa: restaurantes, delivery, cafés, lanchonetes, açaí
- **Uber/Taxi** — transporte por aplicativo para deslocamentos cotidianos; **não incluir** viagens longas ou transfers de aeroporto (são sazonais)
- **Farmácia** — medicamentos de uso corrente; **não incluir** medicamentos caros de uso esporádico (tratar como sazonal com provisão separada)

---

## Regras de Provisão para Sazonais

Para gastos que não são mensais mas se repetem com regularidade, calcule uma provisão mensal a ser reservada:

```
Provisão mensal = Valor do ciclo ÷ Duração do ciclo em semanas × 4,33
```

| Tipo de gasto | Como calcular | Exemplo |
|--------------|---------------|---------|
| Pacote de sessões (fisio, terapia, aulas) | Valor ÷ nº de semanas do ciclo × 4,33 | R$1.200 por pacote de 10 aulas (2×/semana) = ciclo de 5 semanas → R$1.040/mês |
| Medicamento de uso prolongado | Valor ÷ duração em semanas × 4,33 | R$500 que dura 8 semanas → R$271/mês |
| Imposto anual | Valor ÷ 12 | R$2.400/ano → R$200/mês |
| Manutenção periódica | Valor ÷ intervalo em meses | R$600 a cada 4 meses → R$150/mês |

---

## Tipos de Lançamento no Extrato — Guia Genérico

Para identificar lançamentos, procure padrões nestas categorias:

**Receitas:**
- Transferências de CNPJ ou empresa → salário / honorários
- Transferências de pessoa física mensais com valor similar → reembolso de parceiro ou aluguel recebido
- "REND PAGO" ou similar → rendimento de aplicação financeira

**Débitos automáticos de contas fixas:**
- "DA [NOME DA CONCESSIONÁRIA]" → energia, água, gás
- "DEB AUTOR [NOME DA SEGURADORA]" → seguro
- "PAG TIT INT [CÓDIGO]" → boleto (pergunte ao usuário o que é)

**Investimentos:**
- "APLICACAO", "APLICAC", "CDB", "COFRINHO", "POUPANÇA" → poupança/investimento, não é gasto

**Impostos:**
- Pagamentos para Receita Federal, SEFAZ, prefeitura → pergunte se é mensal ou anual

**Pagamentos de cartão:**
- Débito automático com o nome do banco/bandeira → fatura de cartão. Confirme se o valor bate com a fatura.

---

## Checklist de Fechamento Mensal

- [ ] Configuração do usuário registrada (cartões, divisão de casa)
- [ ] Receita total identificada e categorizada
- [ ] Reembolso de parceiro validado (se aplicável)
- [ ] Faturas de cartão conferidas contra o extrato
- [ ] Parcelamentos ativos mapeados (identificar quais encerram em breve)
- [ ] Sazonalidades do mês isoladas com provisões calculadas
- [ ] Lançamentos ambíguos esclarecidos com o usuário
- [ ] Assinaturas listadas com ação sugerida para cada uma
- [ ] Fotografia atualizada com valores reais (se fornecida)
- [ ] Diário recalculado com base no mês real
- [ ] Orientações práticas para o próximo mês definidas
