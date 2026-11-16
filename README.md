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

## Ranking compartilhado

Esta versão do repositório não inclui o ranking entre pessoas. O ranking depende de banco de dados e login oferecidos pela plataforma onde o app foi publicado originalmente. Fora dela, a seção de ranking fica oculta e o app funciona normalmente, só com o histórico local.

## Publicar no GitHub Pages

1. Crie um repositório no GitHub e envie `index.html` e `README.md`.
2. Abra **Settings > Pages**.
3. Em **Build and deployment**, escolha **Deploy from a branch**, selecione a branch `main` e a pasta `/ (root)`.
4. Salve. Em alguns minutos o app fica disponível no endereço mostrado na própria página de configuração.

O app é um único arquivo HTML. Ele carrega as fontes do Google Fonts e não depende de nenhuma outra biblioteca.
