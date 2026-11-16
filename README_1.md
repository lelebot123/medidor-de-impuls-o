# Medidor de Impulsão

Aplicativo web que mede a impulsão vertical de atletas de vôlei a partir de um vídeo do salto. Não precisa de fita, parede nem medida do atleta.

## Como funciona

1. Grave o salto com a câmera parada, de lado, com o atleta inteiro no quadro e os pés visíveis, ou escolha um vídeo da galeria.
2. Avance quadro a quadro e marque o quadro da **decolagem** (primeiro quadro com os dois pés fora do chão) e o da **aterrissagem** (primeiro quadro em que a ponta de um pé toca o chão).
3. O app calcula o tempo de voo e a altura do salto com:

```
h = g · t² / 8        (g = 9,80665 m/s²)
```

Um voo de 0,60 s resulta em cerca de 44 cm.

## Precisão

A precisão depende dos quadros por segundo do vídeo. A 30 fps, errar um quadro em cada marca muda o resultado em alguns centímetros. Em câmera lenta de 120 ou 240 fps o erro cai para menos de 1 cm. O app mostra o erro de um quadro junto com o resultado.

- Se o vídeo foi gravado em câmera lenta e toca mais devagar que o real, informe o **fator de câmera lenta** (por exemplo, 4 se o salto aparece 4 vezes mais devagar).
- Os quadros por segundo são detectados automaticamente e podem ser corrigidos.
- Dobrar os joelhos ou esticar as pernas antes de tocar o chão aumenta o tempo de voo e infla o resultado. O atleta deve aterrissar com o corpo estendido, como na decolagem.

## Histórico

As medições salvas ficam apenas no navegador do aparelho (`localStorage`).

## Ranking com login por e-mail (Supabase)

O ranking é público para leitura. Para enviar um salto, a pessoa entra com o e-mail: o app envia um link de acesso e não há senha. O ranking guarda o melhor salto de cada pessoa.

### Configuração (uma vez)

1. Crie uma conta e um projeto gratuito em https://supabase.com.
2. No projeto, abra **SQL Editor**, cole o conteúdo de `supabase.sql` e clique em **Run**.
3. Abra **Project Settings > API** e copie o **Project URL** e a chave **anon public**. A chave anon foi feita para ficar visível na página, e quem protege os dados são as regras do passo 2.
4. No `index.html`, procure `COLE_AQUI_O_ENDERECO_DO_PROJETO` e `COLE_AQUI_A_CHAVE_PUBLICA_ANON` e troque pelos dois valores.
5. Abra **Authentication > URL Configuration**. Em **Site URL**, coloque o endereço do seu GitHub Pages (por exemplo `https://seunome.github.io/medidor-impulsao/`). Em **Redirect URLs**, adicione o mesmo endereço.
6. Envie o `index.html` atualizado ao repositório.

### Limites e cuidados

- O envio de e-mails do plano gratuito do Supabase tem limite baixo (poucos e-mails por hora). Para um grupo grande entrar ao mesmo tempo, configure um serviço de e-mail próprio em **Authentication > SMTP Settings**.
- A altura é calculada no aparelho de cada pessoa. O banco recusa valores acima de 150 cm ou 1,5 s de voo, mas não consegue conferir se o vídeo é verdadeiro. Para apagar uma marca suspeita, abra **Table Editor > ranking** e remova a linha.

## Publicar no GitHub Pages

1. Envie `index.html`, `supabase.sql` e `README.md` ao repositório.
2. Abra **Settings > Pages**.
3. Em **Build and deployment**, escolha **Deploy from a branch**, selecione a branch `main` e a pasta `/ (root)`.
4. Salve. Em alguns minutos o app fica disponível no endereço mostrado na própria página de configuração.

O app é um único arquivo HTML. Ele carrega as fontes do Google Fonts e a biblioteca do Supabase por CDN.
