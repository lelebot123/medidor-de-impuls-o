-- Ranking do Medidor de Impulsão
-- Cole este arquivo inteiro no SQL Editor do Supabase e clique em Run.

create table if not exists public.ranking (
  user_id uuid primary key references auth.users(id) on delete cascade,
  nick text not null check (char_length(nick) between 1 and 24),
  best_cm numeric not null check (best_cm > 0 and best_cm <= 150),
  best_t numeric not null check (best_t > 0 and best_t <= 1.5),
  n integer not null default 1 check (n >= 1),
  attempts jsonb not null default '[]'::jsonb,
  updated_at timestamptz not null default now()
);

alter table public.ranking enable row level security;

-- Qualquer pessoa pode ver o ranking, sem login.
drop policy if exists "ranking_leitura_publica" on public.ranking;
create policy "ranking_leitura_publica"
  on public.ranking for select
  using (true);

-- Só quem entrou com e-mail grava, e só a própria linha.
drop policy if exists "ranking_inserir_proprio" on public.ranking;
create policy "ranking_inserir_proprio"
  on public.ranking for insert
  to authenticated
  with check (auth.uid() = user_id);

drop policy if exists "ranking_atualizar_proprio" on public.ranking;
create policy "ranking_atualizar_proprio"
  on public.ranking for update
  to authenticated
  using (auth.uid() = user_id)
  with check (auth.uid() = user_id);

grant select on public.ranking to anon, authenticated;
grant insert, update on public.ranking to authenticated;

-- Para remover uma marca suspeita, abra Table Editor > ranking e apague a linha.
