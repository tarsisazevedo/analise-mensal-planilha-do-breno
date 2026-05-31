# 📊 Análise Mensal — Planilha do Breno

Skill para o **Claude (Cowork)** que analisa sua planilha financeira mensal, cruza extrato bancário com faturas de cartão, atualiza sua fotografia financeira e calcula o diário.

---

## ✅ O que essa skill faz

- Lê seu extrato bancário e faturas de cartão (PDF)
- Separa gastos pessoais, da casa, investimentos e sazonais
- Identifica seus maiores gastos e oportunidades de economia
- Atualiza a sua **fotografia financeira** com os valores reais do mês
- Recalcula o **diário** (projeção de gastos variáveis)
- Lista todas as suas assinaturas e sugere o que revisar
- Gera um relatório completo do mês

---

## 📥 Como instalar

**Você precisa ter o [Claude para Desktop (Cowork)](https://claude.ai/download) instalado.**

1. Baixe o arquivo **`analise-financeira.skill`** na seção [Releases](../../releases) desta página
2. Abra o arquivo — o Cowork vai reconhecer automaticamente
3. Clique em **"Save skill"**
4. Pronto! A skill está instalada ✓

---

## 🚀 Como usar

1. Abra uma nova conversa no Claude (Cowork)
2. Faça upload dos seus PDFs (extrato + faturas do mês)
3. Digite:

```
/analise-financeira analisa meu mês de maio
```

> Se for a primeira vez, Claude vai te fazer 3 perguntas rápidas para entender como você organiza suas finanças (cartão, divisão de contas da casa, etc.). Você só responde uma vez.

4. Aguarde — Claude vai ler tudo e gerar o relatório completo.

---

## 📄 O que você pode enviar

| Tipo de arquivo | Como enviar |
|---|---|
| Extrato bancário (PDF) | Arraste para o chat |
| Fatura do cartão (PDF) | Arraste para o chat |
| Planilha fotografia (.xlsx) | Arraste para o chat |
| Planilha no Google Sheets | Cole o link no chat |

---

## ❓ Dúvidas frequentes

**Precisa enviar todos os arquivos de uma vez?**
Sim, envie tudo junto antes de digitar o comando. Assim Claude lê tudo de uma vez.

**Funciona com qualquer banco?**
Sim, desde que o extrato seja em PDF com texto selecionável (não foto/scan).

**E se eu não usar cartão de crédito?**
Sem problema — Claude vai perguntar na primeira vez e adaptar a análise para funcionar só com o extrato.

**Como dividir as contas de casa com meu parceiro/a?**
Claude pergunta como você organiza isso e se adapta à sua realidade — não precisa ser do mesmo jeito que outra pessoa.

**Onde fica o relatório gerado?**
Claude salva um arquivo `.md` na pasta que você tiver conectada ao Cowork.

---

## 🔄 Atualizações

Quando uma nova versão for publicada, repita o processo de instalação — baixe o novo `.skill` e clique em "Save skill". A versão anterior é substituída automaticamente.

---

## 🤝 Sugestões e melhorias

Achou algo que não funcionou bem ou quer sugerir uma melhoria? Abre uma [issue](../../issues) aqui no repositório ou fala direto com quem mantém a skill.
