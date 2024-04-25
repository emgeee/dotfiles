
function llama_ui
    echo "Starting ollama server"
    open -a Ollama

    set PORT 3050

    echo "Starting ollama webui on port $PORT"
    docker run -d -p $PORT:8080 \
        --add-host=host.docker.internal:host-gateway \
        -v open-webui:/app/backend/data \
        --name open-webui \
        --restart always ghcr.io/open-webui/open-webui:main

    echo "http://localhost:$PORT"
end
