from pydantic_settings import BaseSettings, SettingsConfigDict

class Settings(BaseSettings):
    API_V1_STR: str = "/api/v1"
    PROJECT_NAME: str = "Bawarchi API"
    FIREBASE_CREDENTIALS_PATH: str = "serviceAccountKey.json"
    SPOONACULAR_API_KEY: str = ""

    model_config = SettingsConfigDict(env_file=".env")

settings = Settings()
