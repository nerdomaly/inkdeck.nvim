-- Interactive wrappers around this bundle's own scripts/new_piece.py and
-- scripts/build_index.py, ported from a companion document repo's own
-- scripts/ dir (type/slug/notes.md convention, title/status/description
-- frontmatter — see that repo's README.md for the full rules). Needs
-- python3 on PATH. Both scripts operate on the current working directory,
-- which config.rootdir anchors to the document repo's git root, not on
-- wherever this bundle itself happens to be installed.

local scripts_dir = vim.fs.joinpath(vim.fn.stdpath("config"), "scripts")

local PIECE_TYPES = { "story", "poem", "article", "book" }
local STATUSES = { "idea", "drafting", "revising", "done" }

local function notify_result(label, result, on_success)
  vim.schedule(function()
    if result.code ~= 0 then
      vim.notify(label .. ": " .. vim.trim(result.stderr or ""), vim.log.levels.ERROR)
      return
    end
    on_success(vim.trim(result.stdout or ""))
  end)
end

local function new_piece(piece_type, name, description, status)
  local cwd = vim.fn.getcwd()
  vim.system({
    "python3",
    vim.fs.joinpath(scripts_dir, "new_piece.py"),
    "--type",
    piece_type,
    "--name",
    name,
    "--description",
    description,
    "--status",
    status,
  }, { cwd = cwd, text = true }, function(result)
    notify_result("new_piece", result, function(stdout)
      vim.notify(stdout, vim.log.levels.INFO)
      local rel = stdout:match("^created (.+)/$")
      if rel then
        vim.cmd.edit(vim.fs.joinpath(cwd, rel, "notes.md"))
      end
    end)
  end)
end

vim.api.nvim_create_user_command("NewPiece", function()
  vim.ui.select(PIECE_TYPES, { prompt = "Piece type" }, function(piece_type)
    if not piece_type then
      return
    end
    vim.ui.input({ prompt = "Name: " }, function(name)
      if not name or name == "" then
        return
      end
      vim.ui.input({ prompt = "Description: " }, function(description)
        if not description or description == "" then
          return
        end
        vim.ui.select(STATUSES, { prompt = "Status" }, function(status)
          if not status then
            return
          end
          new_piece(piece_type, name, description, status)
        end)
      end)
    end)
  end)
end, { desc = "Scaffold a new story/poem/article/book" })

vim.api.nvim_create_user_command("BuildIndex", function()
  vim.system(
    { "python3", vim.fs.joinpath(scripts_dir, "build_index.py") },
    { cwd = vim.fn.getcwd(), text = true },
    function(result)
      notify_result("build_index", result, function()
        vim.notify("INDEX.md rebuilt", vim.log.levels.INFO)
      end)
    end
  )
end, { desc = "Rebuild INDEX.md from notes.md frontmatter" })

vim.keymap.set("n", "<leader>np", "<cmd>NewPiece<cr>", { desc = "New piece" })
vim.keymap.set("n", "<leader>ri", "<cmd>BuildIndex<cr>", { desc = "Rebuild index" })
