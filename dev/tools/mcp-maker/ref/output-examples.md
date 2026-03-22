# MCP Maker — Output Templates

## Python in-process (Claude Agent SDK + Pydantic)

```python
import os
from claude_agent_sdk import tool, create_sdk_mcp_server
from pydantic import BaseModel, Field

class SearchInput(BaseModel):
    query: str = Field(..., min_length=1, max_length=500)
    max_results: int = Field(default=10, ge=1, le=100)

@tool("search", "Search for items matching a query.", SearchInput.model_json_schema())
async def search(args):
    try:
        data = SearchInput(**args)
    except Exception as e:
        return {"content": [{"type": "text", "text": f"Validation error: {e}"}]}
    api_key = os.environ.get("SEARCH_API_KEY", "")
    if not api_key:
        return {"content": [{"type": "text", "text": "Error: SEARCH_API_KEY not set"}]}
    # TODO: implement search logic
    return {"content": [{"type": "text", "text": f"Results for: {data.query}"}]}

server = create_sdk_mcp_server("my-server", tools=[search])
```

---

## Python standalone stdio (FastMCP)

```python
import os
from mcp.server.fastmcp import FastMCP
from pydantic import BaseModel, Field

mcp = FastMCP("my-server")

class NoteInput(BaseModel):
    note_id: str = Field(..., min_length=1, max_length=64, pattern=r"^[a-z0-9\-]+$")

@mcp.tool()
def read_note(note_id: str) -> str:
    """Read a note file by its ID (alphanumeric + dash, max 64 chars)."""
    base = os.path.realpath("./notes")
    path = os.path.realpath(os.path.join(base, f"{note_id}.md"))
    if not path.startswith(base):
        return "Error: path traversal rejected"
    if not os.path.isfile(path):
        return f"Error: note not found: {note_id}"
    try:
        with open(path) as f:
            return f.read()
    except OSError as e:
        return f"Error reading note: {e}"

@mcp.resource("notes://{note_id}")
def note_resource(note_id: str) -> str:
    """Expose a note as a readable resource."""
    return read_note(note_id)

@mcp.prompt()
def summarize_note(note_id: str) -> str:
    """Prompt template: summarize the given note."""
    return f"Please read and summarize note with ID '{note_id}'."

if __name__ == "__main__":
    mcp.run()
```

---

## TypeScript in-process (Claude Agent SDK + Zod)

```typescript
import { tool, createSdkMcpServer } from "@anthropic-ai/claude-agent-sdk";
import { z } from "zod";

const searchTool = tool(
    "search",
    "Search for items matching a query.",
    { query: z.string().min(1).max(500), maxResults: z.number().int().min(1).max(100).default(10) },
    async (args) => {
        const apiKey = process.env.SEARCH_API_KEY ?? "";
        if (!apiKey) return { content: [{ type: "text", text: "Error: SEARCH_API_KEY not set" }] };
        try {
            // TODO: implement search logic
            return { content: [{ type: "text", text: `Results for: ${args.query}` }] };
        } catch (e) {
            return { content: [{ type: "text", text: `Error: ${e}` }] };
        }
    }
);

export const server = createSdkMcpServer({ name: "my-server", tools: [searchTool] });
```

---

## TypeScript standalone stdio (@modelcontextprotocol/sdk)

```typescript
import { McpServer } from "@modelcontextprotocol/sdk/server";
import { StdioServerTransport } from "@modelcontextprotocol/sdk/server/stdio";
import { z } from "zod";

const server = new McpServer({ name: "my-server", version: "1.0.0" });

server.tool(
    "read_note",
    { note_id: z.string().min(1).max(64).regex(/^[a-z0-9\-]+$/) },
    async ({ note_id }) => {
        try {
            // TODO: read note file with path traversal check
            return { content: [{ type: "text", text: `Note: ${note_id}` }] };
        } catch (e) {
            return { content: [{ type: "text", text: `Error: ${e}` }] };
        }
    }
);

const transport = new StdioServerTransport();
await server.connect(transport);
```

---

## .env.example

```
SEARCH_API_KEY=your-api-key-here
DATABASE_URL=postgresql://user:pass@localhost/db
```

---

## Connection snippet (in-process, Python)

```python
from claude_agent_sdk import query, ClaudeAgentOptions, ResultMessage
from my_server import server

async for message in query(
    prompt="Use the tools to search for ...",
    options=ClaudeAgentOptions(mcp_servers={"my-server": server})
):
    if isinstance(message, ResultMessage):
        print(message.result)
```

---

## Connection snippet (standalone stdio, claude_desktop_config.json)

```json
{
  "mcpServers": {
    "my-server": {
      "command": "python3",
      "args": ["my_server.py"],
      "env": { "SEARCH_API_KEY": "your-key" }
    }
  }
}
```
