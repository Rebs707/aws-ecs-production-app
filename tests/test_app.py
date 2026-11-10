import pytest
from app import app


@pytest.fixture
def client():
    app.config.update(TESTING=True)
    with app.test_client() as client:
        yield client


def test_home_returns_200(client):
    response = client.get("/")
    assert response.status_code == 200


def test_home_returns_expected_message(client):
    response = client.get("/")
    assert response.get_data(as_text=True) == "Hello from AWS ECS!"


def test_health_returns_200(client):
    response = client.get("/health")
    assert response.status_code == 200


def test_health_returns_expected_json(client):
    response = client.get("/health")
    assert response.get_json() == {
        "status": "healthy",
        "service": "aws-ecs-production-app"
    }


def test_unknown_route_returns_404(client):
    response = client.get("/unknown")
    assert response.status_code == 404
