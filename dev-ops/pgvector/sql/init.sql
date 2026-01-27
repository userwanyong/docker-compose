-- 安装 pgvector 扩展
CREATE
EXTENSION IF NOT EXISTS vector;

-- 删除现有表
DROP TABLE IF EXISTS vector_store;

-- 手动创建向量存储表
CREATE TABLE IF NOT EXISTS vector_store
(
    id       TEXT PRIMARY KEY,
    content  TEXT,
    metadata JSON,
    embedding VECTOR(1024)
);

-- 创建索引
CREATE INDEX IF NOT EXISTS vector_store_embedding_idx
    ON vector_store USING hnsw (embedding vector_cosine_ops);

-- 删除旧的表（如果存在）
DROP TABLE IF EXISTS public.vector_store_openai;

-- 创建新的表，使用UUID作为主键
CREATE TABLE public.vector_store_openai
(
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    content TEXT NOT NULL,
    metadata JSONB,
    embedding VECTOR(1024)
);