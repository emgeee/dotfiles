
function llama_ui
    echo "Starting ollama server"
    open -a Ollama

    set PORT 3050

    echo "Starting ollama webui on port $PORT"
    docker run -p $PORT:8080 \
        --rm \
        -e WEBUI_AUTH=false \
        --add-host=host.docker.internal:host-gateway \
        -v open-webui:/app/backend/data \
        --name open-webui \
        # --restart always \
        ghcr.io/open-webui/open-webui:main

    echo "http://localhost:$PORT"
end
