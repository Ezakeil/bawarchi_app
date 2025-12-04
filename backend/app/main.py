from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from app.core.config import settings
from app.services.firebase_service import initialize_firebase
from app.api.v1.router import api_router

app = FastAPI(title=settings.PROJECT_NAME)

# CORS
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

@app.on_event("startup")
async def startup_event():
    initialize_firebase()

@app.get("/")
async def health_check():
    return {"status": "Bawarchi Brain is Online", "version": "1.0"}

app.include_router(api_router, prefix=settings.API_V1_STR)
