"""Aplicação Flask da plataforma ALFAS (estrutura inicial)."""
from flask import Flask, jsonify


def create_app():
    """Cria e configura a aplicação Flask."""
    app = Flask(__name__)

    @app.get("/api/health")
    def health():
        """Indica que a API está a funcionar."""
        return jsonify(status="ok")

    return app
