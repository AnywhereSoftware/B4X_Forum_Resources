import os
os.environ["HF_HUB_OFFLINE"] = "1"

import numpy as np
import base64
import warnings
from sentence_transformers import SentenceTransformer

warnings.filterwarnings("ignore")

model = None

def init_model():
    global model
    if model is None:
        print("Loading LLM...")
        model = SentenceTransformer('paraphrase-multilingual-MiniLM-L12-v2')
        print("Model Loaded with success")
    return "Model Ready"

def get_embedding(text):
    # Creating vector
    vector = model.encode(text)
    # convert to Float32 Bytes for SQLite Vector
    blob_bytes = vector.astype(np.float32).tobytes()
    # return as Base64
    return base64.b64encode(blob_bytes).decode('utf-8')
