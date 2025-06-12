

## **Complete Java setup in neovim**

---

`Inspired by:` Unknown Koder [youtube](https://www.youtube.com/watch?v=zbpF3te0M3g)
"Complete jnd Simple NeoVim Configuration From SCRATCH | Turn NeoVim into a Java Full Stack IDE"
`find all the details on:` [github repo](https://github.com/unknownkoder/Java-FullStack-NeoVim-Configuration/)

>[!NOTE]
check out nvim-java plugin configs in [[~/notes/installation & setup/nvim.java-setup.md|nvim.java-setup.md]]

**_reminder: dont forget to update the link_**

---
### **Table of contents**

* 1. [Treesitter](#treesitter)          -- For nice syntax highlighting
* 2. [Lsp Config](#lsp-config)          -- Language Servers Protocol
* 3. [JDTLS](#jdtls)          -- Java Language Server
* 4. [Auto CMDs](#auto-cmds)            -- For automating actions 
* 5. [Nvim DAP](#nvim-dap)          -- Integrate debugging
* 6. [Spring Boot Nvim](#spring-boot-nvim)          -- Enhance Java/Spring Boot development
* 7. [None LS](#none-ls)            -- Fascilitates LSP support
* 8. [CMPs](#cmps)          -- The Core Completion Engine
* 9. [Harpoon](#harpoon)            -- Easier navigations of files
* 10. [Comment](#comment)            -- Easier comment blocks
* 11. [Git](#git)           -- Git integration
* 12. [Autopairs](#autopairs)        -- Insert pairs of matching characters
* 13. [Lualine](#lualine)           -- Customizable and feature rich statusline
* 14. [Wich key](#which-key)            -- Discover and Remember the keymappings


---
### **File structure:**

_**reminder:**_ dont forget to put the file structure in here at the end.

---
# **Treesitter**

* **What is treesitter?**
    * It is a plugin used to **beatify your code** inside of neovim.

* **How it works:**
    * It reads the extension and contents of the file and and then determines the language you're writing in, and if you have the current language processor installed for treesitter **parse** your code and **highlight different symbols** based on the treesitter parsing library.

* **What advantages does it have:**
    * Improves **accuarcy and performance** compared to traditional regex-based syntax highlighting.
    * better **code comprehension**
    * enhanced **code navigation** and **contextual understanding**.

###### Installation and setup 

>[!NOTE]
>1. all of the configuraions are going to be in `~/.config/nvim/` folder, you can find **file structure** [here](###file-structure)
>2. check out [[~/notes/configurations/nvim.config-plugman.md|nvim.config-plugman.md]] before you start setting up & configuring plugins

_**reminder:**_ dont forget to update the internal link



* `Step 1:` **Write the plugin config.**



    * Open a new `treesitter.lua` file in `plugins/java/` for configurations
(check it out in [[~/notes/configurations/nvim.config-plugman.md|nvim.config-plugman.md]])

    _**reminder:**_ dont forget to update the link
    
   * Write the config:
    ```lua
    return {
        "nvim-treesitter/nvim-treesitter",
        dependencies = {
            -- ts-autotag utilizes treesitter to understand the code structure to automatically close tsx tags
            "windwp/nvim-ts-autotag"
        },
        -- when the plugin builds run the TSUpdate command to ensure all our servers are installed and updated
        build = ':TSUpdate',
        config = function() -- (note: you could store configs in /configs folder if you wanted to)
            -- gain access to the treesitter config functions
            local ts_config = require("nvim-treesitter.configs")

            -- call the treesitter setup function with properties to configure our experience
            ts_config.setup({
                -- make sure we have vim, vimdoc, lua, java, javascript, typescript, html, css, json, tsx, markdown, markdown, inline markdown and gitignore highlighting servers
                ensure_installed = {"vim", "vimdoc", "lua", "java", "javascript", "typescript", "html", "css", "json", "tsx", "markdown", "markdown_inline", "gitignore"},
                -- make sure highlighting it anabled
                highlight = {enable = true},
                -- enable tsx auto closing tag creation
                autotag = {
                    enable = true
                }
            })
        end
    }

    ```



* `Step 2:` **Load the configs out in `init.lua` file (central plugin manager)**
 


    * Add this like to corresponfing section:
    ```lua
    -- Load plugins from the 'java' development group
    extend_plugins(require("plugins.java.treesetter"))

    ```
    * This ensures the treesitter plugin in the `plugins/java/` is loaded.
    * **Note:** if you have existing treesitter plugin in base `plugins/init.lua` file, you can either get rid of that by deleting/commenting, or update it.    
        * if you wanna update the plugin directly in `plugins/init.lua` file, put the configuraions in an **empty table** `{}` instead of the **return table** `return {}`.



---
# **Lsp Configs**

Originally developed for **Microsoft** for **VsCode**, then went open source.

* **What is LSP?**
    * LSP - Language Servers Protocol is an actual server application that notifies for **code errors** and gives **suggestions for code** in direct contact with NeoVim. 


---
###### Installation and setup


* In this sections we set up **5 (five)** different plugins:

    * **1.** `mason`          
        
        * **What is mason?**

          * Mason.nvim is a plugin specifically focused on managing Language Server
          Protocol (LSP) bineries.
        

        * **What are the advantages?**

          * It **automates installation and management** of this binaries.
          * makes it easier for NeoVim users to **set up and use** language protocols
          for **code completion**, **syntax checking** and more.
          * Simplifies the configuration process. 
          * ensures **smoother integration** of language server capabilities within NeoVim.


    * **2.** `mason-lspconfig`

        * **What is Mason-lspconfig.nvim?**

          * it is a plugin works in conjuction with Mason.nvim for managing 
          LSP configurations.


        * **What it does?**

          * It provides the set of **pre-configured settings** for various programming
          languages and frameworks.

          * Simplifies configuring LSP servers by offering **ready-made configuration**
          tailored to different **development environments** - incearing productivity.


    * **3.** `mason-nvim-dap`
        
        * **What is Mason-nvim-dap?**

          * Nvim-dap is a plugin that brings the debugger integeration to Neovim.


        * **What features does it offer?**
          
          It imlements the Debug Adapter Protocol (DAP), providing features like:
          * Breakpoitns
          * Vairable insertion
          * Stepping through the code
          * Allows to debug code directly within the editor, and more.


    * **4.** `nvim-jdtls`
        
        * **What is Nvim-jdtls?**    
          
          * It is a plugin that integrates the Java Language Server (JDTLS) wit Neovim


        * **What features does it offer for Java development?**

          * Code completion
          * Syntax checking 
          * Refactroing
          * Inelligent code assistance and navigation.


    * **5.** `nvim-lspconfig`

        * **What is Nvim-lspconfig?**
          
          * It is a plugin that simplifies the **configuration**  of LSP in NeoVim.
        

        * ** What features does it offer?** 
         
          * Offers the **simple to use interface** to confugure LSP.
          * Streamlines the **integration** of Language server capabilities within NeoVim.
          * Enhances the **development experience** accross the multiple programming
          languages and frameworks.



* `Step 1` 


    * We're gonna need the seperate file for **lsp-config** plugins.
    * Make the `lsp-cofig.lua` file in `lua/plugins`
     ```lua
     return {
         {
             "williamboman/mason.nvim",
             config = function()
                 -- setup mason with default properties
                 require("mason").setup()
             end
         },
         -- mason lsp config utilizes mason to automatically ensure lsp servers you want installed are installed
         {
             "williamboman/mason-lspconfig.nvim",
             config = function()
                 -- ensure that we have lua language server, typescript launguage server, java language server, and java test language server are installed
                 require("mason-lspconfig").setup({
                     ensure_installed = { "lua_ls", "ts_ls", "jdtls" },
                 })
             end
         },
         -- mason nvim dap utilizes mason to automatically ensure debug adapters you want installed are installed, mason-lspconfig will not automatically install debug adapters for us
         {
             "jay-babu/mason-nvim-dap.nvim",
             config = function()
                 -- ensure the java debug adapter is installed
                 require("mason-nvim-dap").setup({
                     ensure_installed = { "java-debug-adapter", "java-test" }
                 })
             end
         },
         -- utility plugin for configuring the java language server for us
         {
             "mfussenegger/nvim-jdtls",
             dependencies = {
                 "mfussenegger/nvim-dap",
             }
         },
         {
             "neovim/nvim-lspconfig",
             config = function()
                 -- get access to the lspconfig plugins functions
                 local lspconfig = require("lspconfig")
     
                 local capabilities = require("cmp_nvim_lsp").default_capabilities()
     
                 -- setup the lua language server
                 lspconfig.lua_ls.setup({
                     capabilities = capabilities,
                 })
     
                 -- setup the typescript language server
                 lspconfig.ts_ls.setup({
                     capabilities = capabilities,
                 })
     
                 -- Set vim motion for <Space> + c + <Shift>H to show code documentation about the code the cursor is currently over if available
                 vim.keymap.set("n", "<leader>cH", vim.lsp.buf.hover, { desc = "[C]ode [H]over Documentation" })
                 -- Set vim motion for <Space> + c + d to go where the code/variable under the cursor was defined
                 vim.keymap.set("n", "<leader>cd", vim.lsp.buf.definition, { desc = "[C]ode Goto [D]efinition" })
                 -- Set vim motion for <Space> + c + a for display code action suggestions for code diagnostics in both normal and visual mode
                 vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "[C]ode [A]ctions" })
                 -- Set vim motion for <Space> + c + r to display references to the code under the cursor
                 vim.keymap.set("n", "<leader>cr", require("telescope.builtin").lsp_references, { desc = "[C]ode Goto [R]eferences" })
                 -- Set vim motion for <Space> + c + i to display implementations to the code under the cursor
                 vim.keymap.set("n", "<leader>ci", require("telescope.builtin").lsp_implementations, { desc = "[C]ode Goto [I]mplementations" })
                 -- Set a vim motion for <Space> + c + <Shift>R to smartly rename the code under the cursor
                 vim.keymap.set("n", "<leader>cR", vim.lsp.buf.rename, { desc = "[C]ode [R]ename" })
                 -- Set a vim motion for <Space> + c + <Shift>D to go to where the code/object was declared in the project (class file)
                 vim.keymap.set("n", "<leader>cD", vim.lsp.buf.declaration, { desc = "[C]ode Goto [D]eclaration" })
             end
         }
     }
     
     ```



* `Step 2` **Load the plugins in `plugins/init.lua` central plugin manager**


    * Delete or comment out any existing lsp related plugins from `plugins/init.lua`  file.
    * Update the `plugins/init.lua` - central plugin loader, to include `lsp-config.lua` like so:
     ```lua 
     -- Load plugins from the 'java' development group
     
     -- Previous plugin for treesitter.
     extend_plugins(require("plugins.java.treesitter"))
     -- Add this line to load new set of plugins
     extend_plugins(require("plugins.java.lsp-config"))
     
         ```


* `Step 3` **Make sure plugins are working**

    * 1. Write the files (:w) and reopen NeoVim.
    * 2. You should see the Lazy window pop up and all the dependencies being installed.
    * 3. execute `:Mason` command to check if Java related plugins are are installed.
    * 4. If you see `java-test` and `java-debub` under the **Installed** table, with some other LSP's, fine.
    * 5. If you dont see those, you can manually install it by searching `java` and pressing i while `java-test`
      or `java-dap` in on hover.
    * 6. It is also recommended to install `google-java-format` in same way.


* `Step 4` **Make sure the diagnostics are set up correctly**


    * After you complete the tasks in **Step 3**, you might need to open `jdtls.lua` file to test the
      **diagnostics**.

    * If you see:

      * **Characters:** -- `W` (warning), `H` (hint), `E` (error) or `I` (info) on the **sign column** 
        (the narrow column on the left).
      * **Inline messages:** -- the error/warning text displayed **directly after** the problematic line. 
      * **Floating window** -- a small pop-up window that appears when your cursor is on or near diagnostic.

      it is fine.

    * But if you dont see those you can **troubleshoot** like so:
      
      * Type `:lua print(vim.inspect(vim.diagnostic.config()))` command and press <Enter>.
      * Look at the output. You should see something like:
        ```lua
        {
          float = true,          -- Floating diagnostic windows are ENABLED
          jump = { ... },
          severity_sort = false,
          signs = true,          -- Sign column characters (W, H, E) ARE enabled (this matches what you see)
          underline = true,      -- Problematic text IS underlined
          update_in_insert = false,
          virtual_lines = false,
          virtual_text = true   -- Inline diagnostic text (after the line) is ENABLED
        }
        
        ```

    * Add corresponding parameter inside the `config` function of `nvim-lspconfig` to temporarily override it,
      if you find any of those `DISABLED`
      
      for example:
      ```lua
      {
          "neovim/nvim-lspconfig",
          config = function()
              -- ... your existing lspconfig setup ...
      
              -- Add or modify this line to enable virtual_text
              vim.diagnostic.config({
                  virtual_text = true,
                  -- You can add other options here if you want to explicitly override them
                  -- For example:
                  -- float = true, -- Ensure this is still true
              })
      
              -- ... rest of your lspconfig setup and keymaps ...
          end
      }
      
      ```


* `Step 5` **Fix the warning**

    * If plugins are correctly installed and set up, you should see some warnings for each line with `vim`
      (highlighted by `W`).
    * To fix that, open the **code actions** (use the key binding you set) and mark all instances of `vim.` to 
      be a global variable.


* **In the next sections you're going to configure some of the installed plugins**


---
# **JDTLS**

**JDTLS** - Java Language Server.


###### Configuration


* `Step 1` **Write the configurations**


    * If you installed the plugins `Nvim-jdtls` and others in the last section. you can move onto configuring
      jdtls.
    * There is the specific `lua/configs` folder to store the configurations, we need to open a new `jdtls.lua`
      file in that folder
    * Then write the configs:
     ```lua
     local function get_jdtls()
         -- Get the Mason Registry to gain access to downloaded binaries
         local mason_registry = require("mason-registry")
         -- Find the JDTLS package in the Mason Regsitry
         local jdtls = mason_registry.get_package("jdtls")
         -- Find the full path to the directory where Mason has downloaded the JDTLS binaries
         local jdtls_path = jdtls:get_install_path()
         -- Obtain the path to the jar which runs the language server
         local launcher = vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar")
          -- Declare white operating system we are using, windows use win, macos use mac
         local SYSTEM = "linux"
         -- Obtain the path to configuration files for your specific operating system
         local config = jdtls_path .. "/config_" .. SYSTEM
         -- Obtain the path to the Lomboc jar
         local lombok = jdtls_path .. "/lombok.jar"
         return launcher, config, lombok
     end
     
     local function get_bundles()
         -- Get the Mason Registry to gain access to downloaded binaries
         local mason_registry = require("mason-registry")
         -- Find the Java Debug Adapter package in the Mason Registry
         local java_debug = mason_registry.get_package("java-debug-adapter")
         -- Obtain the full path to the directory where Mason has downloaded the Java Debug Adapter binaries
         local java_debug_path = java_debug:get_install_path()
     
         local bundles = {
             vim.fn.glob(java_debug_path .. "/extension/server/com.microsoft.java.debug.plugin-*.jar", 1)
         }
     
         -- Find the Java Test package in the Mason Registry
         local java_test = mason_registry.get_package("java-test")
         -- Obtain the full path to the directory where Mason has downloaded the Java Test binaries
         local java_test_path = java_test:get_install_path()
          -- Add all of the Jars for running tests in debug mode to the bundles list
          vim.list_extend(bundles, vim.split(vim.fn.glob(java_test_path .. "/extension/server/*.jar", 1), "\n"))
     
          return bundles
     end
     
     local function get_workspace()
         -- Get the home directory of your operating system
         local home = os.getenv "HOME"
         -- Declare a directory where you would like to store project information
         local workspace_path = home .. "/code/workspace/"
         -- Determine the project name
         local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
         -- Create the workspace directory by concatenating the designated workspace path and the project name
         local workspace_dir = workspace_path .. project_name
         return workspace_dir
     end
     
     local function java_keymaps()
         -- Allow yourself to run JdtCompile as a Vim command
         vim.cmd("command! -buffer -nargs=? -complete=custom,v:lua.require'jdtls'._complete_compile JdtCompile lua require('jdtls').compile(<f-args>)")
         -- Allow yourself/register to run JdtUpdateConfig as a Vim command
         vim.cmd("command! -buffer JdtUpdateConfig lua require('jdtls').update_project_config()")
         -- Allow yourself/register to run JdtBytecode as a Vim command
         vim.cmd("command! -buffer JdtBytecode lua require('jdtls').javap()")
         -- Allow yourself/register to run JdtShell as a Vim command
         vim.cmd("command! -buffer JdtJshell lua require('jdtls').jshell()")
     
         -- Set a Vim motion to <Space> + j + o to organize imports in normal mode
         vim.keymap.set('n', '<leader>jo', "<Cmd> lua require('jdtls').organize_imports()<CR>", { desc = "[J]ava [O]rganize Imports" })
         -- Set a Vim motion to <Space> + j + v to extract the code under the cursor to a variable
         vim.keymap.set('n', '<leader>jv', "<Cmd> lua require('jdtls').extract_variable()<CR>", { desc = "[J]ava Extract [V]ariable" })
         -- Set a Vim motion to <Space> + j + v to extract the code selected in visual mode to a variable
         vim.keymap.set('v', '<leader>jv', "<Esc><Cmd> lua require('jdtls').extract_variable(true)<CR>", { desc = "[J]ava Extract [V]ariable" })
         -- Set a Vim motion to <Space> + j + <Shift>C to extract the code under the cursor to a static variable
         vim.keymap.set('n', '<leader>jC', "<Cmd> lua require('jdtls').extract_constant()<CR>", { desc = "[J]ava Extract [C]onstant" })
         -- Set a Vim motion to <Space> + j + <Shift>C to extract the code selected in visual mode to a static variable
         vim.keymap.set('v', '<leader>jC', "<Esc><Cmd> lua require('jdtls').extract_constant(true)<CR>", { desc = "[J]ava Extract [C]onstant" })
         -- Set a Vim motion to <Space> + j + t to run the test method currently under the cursor
         vim.keymap.set('n', '<leader>jt', "<Cmd> lua require('jdtls').test_nearest_method()<CR>", { desc = "[J]ava [T]est Method" })
         -- Set a Vim motion to <Space> + j + t to run the test method that is currently selected in visual mode
         vim.keymap.set('v', '<leader>jt', "<Esc><Cmd> lua require('jdtls').test_nearest_method(true)<CR>", { desc = "[J]ava [T]est Method" })
         -- Set a Vim motion to <Space> + j + <Shift>T to run an entire test suite (class)
         vim.keymap.set('n', '<leader>jT', "<Cmd> lua require('jdtls').test_class()<CR>", { desc = "[J]ava [T]est Class" })
         -- Set a Vim motion to <Space> + j + u to update the project configuration
         vim.keymap.set('n', '<leader>ju', "<Cmd> JdtUpdateConfig<CR>", { desc = "[J]ava [U]pdate Config" })
     end
     
     local function setup_jdtls()
         -- Get access to the jdtls plugin and all of its functionality
         local jdtls = require "jdtls"
     
         -- Get the paths to the jdtls jar, operating specific configuration directory, and lombok jar
         local launcher, os_config, lombok = get_jdtls()
     
         -- Get the path you specified to hold project information
         local workspace_dir = get_workspace()
     
         -- Get the bundles list with the jars to the debug adapter, and testing adapters
         local bundles = get_bundles()
     
         -- Determine the root directory of the project by looking for these specific markers
         local root_dir = jdtls.setup.find_root({ '.git', 'mvnw', 'gradlew', 'pom.xml', 'build.gradle' });
         
         -- Tell our JDTLS language features it is capable of
         local capabilities = {
             workspace = {
                 configuration = true
             },
             textDocument = {
                 completion = {
                     snippetSupport = false
                 }
             }
         }
     
         local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()
     
         for k,v in pairs(lsp_capabilities) do capabilities[k] = v end
     
         -- Get the default extended client capablities of the JDTLS language server
         local extendedClientCapabilities = jdtls.extendedClientCapabilities
         -- Modify one property called resolveAdditionalTextEditsSupport and set it to true
         extendedClientCapabilities.resolveAdditionalTextEditsSupport = true
     
         -- Set the command that starts the JDTLS language server jar
         local cmd = {
             'java',
             '-Declipse.application=org.eclipse.jdt.ls.core.id1',
             '-Dosgi.bundles.defaultStartLevel=4',
             '-Declipse.product=org.eclipse.jdt.ls.core.product',
             '-Dlog.protocol=true',
             '-Dlog.level=ALL',
             '-Xmx1g',
             '--add-modules=ALL-SYSTEM',
             '--add-opens', 'java.base/java.util=ALL-UNNAMED',
             '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
             '-javaagent:' .. lombok,
             '-jar',
             launcher,
             '-configuration',
             os_config,
             '-data',
             workspace_dir
         }
     
          -- Configure settings in the JDTLS server
         local settings = {
             java = {
                 -- Enable code formatting
                 format = {
                     enabled = true,
                     -- Use the Google Style guide for code formattingh
                     settings = {
                         url = vim.fn.stdpath("config") .. "/lang_servers/intellij-java-google-style.xml",
                         profile = "GoogleStyle"
                     }
                 },
                 -- Enable downloading archives from eclipse automatically
                 eclipse = {
                     downloadSource = true
                 },
                 -- Enable downloading archives from maven automatically
                 maven = {
                     downloadSources = true
                 },
                 -- Enable method signature help
                 signatureHelp = {
                     enabled = true
                 },
                 -- Use the fernflower decompiler when using the javap command to decompile byte code back to java code
                 contentProvider = {
                     preferred = "fernflower"
                 },
                 -- Setup automatical package import oranization on file save
                 saveActions = {
                     organizeImports = true
                 },
                 -- Customize completion options
                 completion = {
                     -- When using an unimported static method, how should the LSP rank possible places to import the static method from
                     favoriteStaticMembers = {
                         "org.hamcrest.MatcherAssert.assertThat",
                         "org.hamcrest.Matchers.*",
                         "org.hamcrest.CoreMatchers.*",
                         "org.junit.jupiter.api.Assertions.*",
                         "java.util.Objects.requireNonNull",
                         "java.util.Objects.requireNonNullElse",
                         "org.mockito.Mockito.*",
                     },
                     -- Try not to suggest imports from these packages in the code action window
                     filteredTypes = {
                         "com.sun.*",
                         "io.micrometer.shaded.*",
                         "java.awt.*",
                         "jdk.*",
                         "sun.*",
                     },
                     -- Set the order in which the language server should organize imports
                     importOrder = {
                         "java",
                         "jakarta",
                         "javax",
                         "com",
                         "org",
                     }
                 },
                 sources = {
                     -- How many classes from a specific package should be imported before automatic imports combine them all into a single import
                     organizeImports = {
                         starThreshold = 9999,
                         staticThreshold = 9999
                     }
                 },
                 -- How should different pieces of code be generated?
                 codeGeneration = {
                     -- When generating toString use a json format
                     toString = {
                         template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}"
                     },
                     -- When generating hashCode and equals methods use the java 7 objects method
                     hashCodeEquals = {
                         useJava7Objects = true
                     },
                     -- When generating code use code blocks
                     useBlocks = true
                 },
                  -- If changes to the project will require the developer to update the projects configuration advise the developer before accepting the change
                 configuration = {
                     updateBuildConfiguration = "interactive"
                 },
                 -- enable code lens in the lsp
                 referencesCodeLens = {
                     enabled = true
                 },
                 -- enable inlay hints for parameter names,
                 inlayHints = {
                     parameterNames = {
                         enabled = "all"
                     }
                 }
             }
         }
     
         -- Create a table called init_options to pass the bundles with debug and testing jar, along with the extended client capablies to the start or attach function of JDTLS
         local init_options = {
             bundles = bundles,
             extendedClientCapabilities = extendedClientCapabilities
         }
     
         -- Function that will be ran once the language server is attached
         local on_attach = function(_, bufnr)
             -- Map the Java specific key mappings once the server is attached
             java_keymaps()
     
             -- Setup the java debug adapter of the JDTLS server
             require('jdtls.dap').setup_dap()
     
             -- Find the main method(s) of the application so the debug adapter can successfully start up the application
             -- Sometimes this will randomly fail if language server takes to long to startup for the project, if a ClassDefNotFoundException occurs when running
             -- the debug tool, attempt to run the debug tool while in the main class of the application, or restart the neovim instance
             -- Unfortunately I have not found an elegant way to ensure this works 100%
             require('jdtls.dap').setup_dap_main_class_configs()
             -- Enable jdtls commands to be used in Neovim
             require 'jdtls.setup'.add_commands()
             -- Refresh the codelens
             -- Code lens enables features such as code reference counts, implemenation counts, and more.
             vim.lsp.codelens.refresh()
     
             -- Setup a function that automatically runs every time a java file is saved to refresh the code lens
             vim.api.nvim_create_autocmd("BufWritePost", {
                 pattern = { "*.java" },
                 callback = function()
                     local _, _ = pcall(vim.lsp.codelens.refresh)
                 end
             })
         end
     
         -- Create the configuration table for the start or attach function
         local config = {
             cmd = cmd,
             root_dir = root_dir,
             settings = settings,
             capabilities = capabilities,
             init_options = init_options,
             on_attach = on_attach
         }
     
         -- Start the JDTLS server
         require('jdtls').start_or_attach(config)
     end
     
     return {
         setup_jdtls = setup_jdtls,
     }
     
     ```



    * **Better way of organizing:**

      * If you wanted to organize configs, you can add **jdtls** and other configurations in a new 
        `lua/configs/java` file.


    * Create `lua/congis/java/jdtls.lua` file.
      
      * You need to explicitly reuire `lspconfig` and other modules here, before the original config file:
      ```lua 
      -- You need to explicitly require lspconfig and other modules here
      local lspconfig = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      local util = require("lspconfig.util")
      
      lspconfig.jdtls.setup({
          -- Your complete JDTLS configuration here, exactly as above.
          -- Ensure all `require`s for utilities (like `util` or `capabilities`)
          -- are present in this file if they are used.
          cmd = {
            "java",
            -- ...
          },
          root_dir = util.root_pattern("pom.xml", "build.gradle", ".git"),
          capabilities = capabilities,
          -- ...
      })
      
      ```


    * You must add a `require` call inside the `config` fuction of `nvim-lspconfig` plugin definition to load
      the this new file:
      
      Change `lua/plugins/lsp-config` like so:
      ```lua
      return {
          -- ... other plugins ...
      
          {
              "neovim/nvim-lspconfig",
              config = function()
                  local lspconfig = require("lspconfig")
                  local capabilities = require("cmp_nvim_lsp").default_capabilities()
      
                  lspconfig.lua_ls.setup({ capabilities = capabilities, })
                  lspconfig.ts_ls.setup({ capabilities = capabilities, })
      
                  -- --- IMPORTANT: YOU MUST REQUIRE YOUR JDTLS CONFIG FILE HERE ---
                  require("configs.java.jdtls") -- This tells NvChad to load your custom jdtls.lua file
                  -- --- END REQUIRE ---
      
                  -- ... your keymaps ...
              end
          }
      }
      
      ```



* `Step 2` **Important points**


    * Inside the `jdtls.lua` file you find `get_workspace` helper function. 
    * Dont forget to set your preferred path of the **workspace folder** there.

    * Below you find `workspace_dir` for specific projects.


---
# **Auto CMDs**

* **What are the Autocommands (autocmds) in NeoVim?**

    * At their core, **autocommands are NeoVims way automating actions based on events**.
      Think of them as "if this happends then do that."
    * They allow you to execute specific commands or Lua functions whenever a certain **event** occurs.
      These events cover almost anything that happens within NeoVim.


* In the [Configurations](######configurations) section you're going to set up autocmds to tell NeoVim instance to start the **JDTLS** (Java Language Server), or when the attach the server to a specific buffer.

**_reminder:_** dont forget to update the internal link.

###### Configuration


* `Step 1` **Write the configurations** 


    * To store the **aucommand configurations**, you're going to need a new `autocmds.lua` file inside 
      `lua/configs/` directory:
    * Write the configs:
     ```lua
     -- Setup our JDTLS server any time we open up a java file
     vim.cmd [[
         augroup jdtls_lsp
             autocmd!
             autocmd FileType java lua require'configs.jdtls'.setup_jdtls()
         augroup end
     ]]
     
     ```


* `Step 2` **Require autocommands in `init.lua` file (central plugin manager)**


    * After you write the configuration in `configs/autocmds.lua`, you're going to have to `require` it in 
      `init.lua` file like so:

     (note that main `nvim/init.lua` differs from `nvim/plugins/init.lua` which
     expects to `return` plugin specifications.)
     
    * The best place to add your `autocommands.lua` file is right after the NvChad's autocommands are loaded.
      This ensures the **custom autocommands** can extend or override NvChad's in needed:
     ```lua 
     -- ~/.config/nvim/init.lua
     
     -- NvChad's default autocommands.
     
     require "options"
     require "nvchad.autocmds"
     
     
     
     -- == Your custom autocommands ==
     
     -- Load the auto commands from the config/autocmds.lua file
     require("configs.autocmds")
     
     -- == End of your custom autocommands ==
     
     
     -- vim.schedule(function()
       require "mappings"
     -- end)
     
     ```


---
# **Nvim DAP**

* **What is Nvim DAP?**
    * It is a plugin that brings debugger integration to NeoVim, allowing users to debug their code directly
      within the editor.
    * More on that in [Lsp Config](#lsp-config) section.

**_reminder:_** Dont forget to update the internal link

* Starting with the next section forward you **Install & Set up** the set of the more **code related** plugins.


###### Installation & Setup


* `Step 1` **Write the configurations**


    * Open new `nvim-dap.lua` file inside the folder `plugins/java/` - where you store all of your plugis.
    * Write the config:
     ```lua 
     return {
         "mfussenegger/nvim-dap",
         dependencies = {
             -- ui plugins to make debugging simplier
             "rcarriga/nvim-dap-ui",
             "nvim-neotest/nvim-nio"
         },
         config = function()
             -- gain access to the dap plugin and its functions
             local dap = require("dap")
             -- gain access to the dap ui plugin and its functions
             local dapui = require("dapui")
     
             -- Setup the dap ui with default configuration
             dapui.setup()
     
              -- setup an event listener for when the debugger is launched
             dap.listeners.before.launch.dapui_config = function()
                 -- when the debugger is launched open up the debug ui
                 dapui.open()
             end
     
             -- set a vim motion for <Space> + d + t to toggle a breakpoint at the line where the cursor is currently on
             vim.keymap.set("n", "<leader>dt", dap.toggle_breakpoint, { desc = "[D]ebug [T]oggle Breakpoint" })
     
             -- set a vim motion for <Space> + d + <Shift>S to start the debugger and launch the debugging ui
             vim.keymap.set("n", "<leader>dS", dap.continue, { desc = "[D]ebug [S]tart" })
     
             -- set a vim motion to close the debugging ui
             vim.keymap.set("n", "<leader>dc", dapui.close, {desc = "[D]ebug [C]lose"})
         end
     }
     
     ```
    
    * **Note:** feel free to change the **keymaps** to your liking.


* `Step 2` **Require the plugin in `plugins/init.lua` file (central plugin loader)** 


    * Dont forget to `require {}` the plugin in `plugins/init.lua` file:
     ```lua 
     -- Add the plugin to the corresponding section:
     
     -- Load plugins from the 'java' development group
     
     -- treesitter:
     extend_plugins(require("plugins.java.treesitter"))
     -- lsp-config:
     extend_plugins(require("plugins.java.lsp-config"))
     -- Add the line below for nvim-dap:
     extend_plugins(require("plugins.java.nvim-dap"))
     
     
     ```


---
# Spring Boot Nvim

* **What is a springboot-nvim?**

    * It is the plugin that brings quality of life features to **Java/Spring Boot** developers.


* **What features does it offer?**

    * Sets up the convenient way to **map a keybinding** to run Spring Boot applications in a new
      **terminal window**.
    * Automatially adds **package declarations** to new files.
    * Incrementally **compies** Java project **on save** to enable **Spring Boot DevTools** to work properly.
    * Provides convenient way to **create new classes**, **enums** and **interfaces**, with more features
      to come.


* `Step 1` **Write the config**


    * Add new plugin called `springboot-nvim.lua` inside the `plugins/java/` folder where you store all the 
      other Java related plugins.
    * Write the config:
     ```lua 
     return {
         "elmcgill/springboot-nvim",
         dependencies = {
             "neovim/nvim-lspconfig",
             "mfussenegger/nvim-jdtls"
         },
         config = function()
             -- gain acces to the springboot nvim plugin and its functions
             local springboot_nvim = require("springboot-nvim")
     
             -- set a vim motion to <Space> + j + r to run the spring boot project in a vim terminal
             vim.keymap.set('n', '<leader>jr', springboot_nvim.boot_run, {desc = "[J]ava [R]un Spring Boot"})
             -- set a vim motion to <Space> + j + c to open the generate class ui to create a class
             vim.keymap.set('n', '<leader>jc', springboot_nvim.generate_class, {desc = "[J]ava Create [C]lass"})
             -- set a vim motion to <Space> + j + i to open the generate interface ui to create an interface
             vim.keymap.set('n', '<leader>ji', springboot_nvim.generate_interface, {desc = "[J]ava Create [I]nterface"})
             -- set a vim motion to <Space> + j + e to open the generate enum ui to create an enum
             vim.keymap.set('n', '<leader>je', springboot_nvim.generate_enum, {desc = "[J]ava Create [E]num"})
     
             -- run the setup function with default configuration
             springboot_nvim.setup({})
         end
     }
     
     ```

    * You can change **keymaps** however you want, but make sure that it **wont interfere default ketmaps.**


* `Step 2` **Return the plugin in the central plugin loader `plugins/init.lua`**


    * Dont forget to laod the plugins in `plugins/init.lua` file - the **central plugin manager**:
     ```lua 
     
     -- Load plugins from the 'java' development group
     
     -- other Java related plugins
     -- Add this line below:
     extend_plugins(require("plugins.java.springboot-nvim"))
     
     
     ```


---
# **None LS**

* **What is None LS?**

    * It is a NeoVim plugin that fascilitates **Language Server Protocol (LSP) support** for the languages that 
      lack dedicated language servers.


* **What features does it offer?**

    * Provides a generic soluion for **syntax checking**, **code completion**, and other **language-specific
      features** by leveraging external tools or scripts.
    * Extends NeoVims capabilities to **wider range of Programming Languages**.
    * Enhances the editing experience for users working with **less common** or **unsupported languages**.


* `Step 1` **Write the configuraions** 


    * Open a new file `none-ls.lua` dedicated for this plugin inside the `plugins/java/` folder.
    * Write the config:
     ```lua 
     return {
         "nvimtools/none-ls.nvim",
         dependencies = {
             "nvimtools/none-ls-extras.nvim",
         },
         config = function()
             -- get access to the none-ls functions
             local null_ls = require("null-ls")
             -- run the setup function for none-ls to setup our different formatters
             null_ls.setup({
                 sources = {
                     -- setup lua formatter
                     null_ls.builtins.formatting.stylua,
                     -- setup eslint linter for javascript
                     require("none-ls.diagnostics.eslint_d"),
                     -- setup prettier to format languages that are not lua
                     null_ls.builtins.formatting.prettier
                 }
             })
     
             -- set up a vim motion for <Space> + c + f to automatically format our code based on which langauge server is active
             vim.keymap.set("n", "<leader>cf", vim.lsp.buf.format, { desc = "[C]ode [F]ormat" })
         end
     }
     
     ```


* `Step 2` **Load the plugin up in `plugins/init.lua`**


    * Dont forget to call the plugin inside the **central plugin loader:** `plugins/init.lua` like so:
     ```lua 
     -- Load plugins from the 'java' development group
     
     --other plugins
     
     --Add this line for none-ls plugin:
     extend_plugins(require("plugins.java.none-ls"))
     
     ```


* `Step 3` **Testing and Troublehooting**


    * After installation it is recommended to test if the plugins is fully loaded and working.
    * You can test it for some simple **code actions** if you want. (use specific key binding you set up info
      plugin configurations, <leader> + c + f  -- [C]ode [F]format)
 
    * If you get `failed to run generator` error message when testing follow these steps below:
      
      * run `:Mason` command and look for the installed table.
      * if you see following there, you dont have to manually install:
        `stylua`
        `prettier`
        `eslint_d`
      
      * If you dont see those manually install those all one by one:
        
        Search for the **plugin name** and press <i> key to install.
        Install `google-java-format` if you didnt install it in previous steps.


---
# **CMPs** 

* **What is CMPs** 
    * CMP - Core Completion Enigne is a **powerful, extensible and asynchronous Comletion framework**
      for NeoVim.


###### Installation & Set up


> [!NOTE]
Plugins you set up and configure by following the steps below are absolutely unnecessary, since Nvchad provides 
all of those configured pretty well by default, but if you want to experiment and learn about the specific 
configurations you can check those out below.

>[!TIP]
If you dont have the following plugin configuration you can find steps to set up at the end of the section:
**Ghost text** (or "Inline Completion") - a completion suggestion that appears directly in your appears 
**directly in you editing buffer**, usually in faded, lighter or otherwise visually distinct color to the **rightof the cursor** as you type.


* In this section you're going to install bunch of plugins:

    * **1.** `LuaSnip`
      
        * **What is LuaSnip?**

          * It is a plugin that enhances the **snippet support** within the editor.


        * **What features does it offer?**
          
          * Allows users to **define** and **expand** snippets of code quickly using the simple **triggers**
            and **placeholders**.
          * Offers **customizable** and **efficient** way to insert **commonly used code patterns.
          * Reduces typing and improves **productivity** during the code sessions.


    * **2** `Cmp LuaSnip`

        * **What is Cmp LuaSnip?**
          
          * Cmp_luasnip is a Neovim plugin that integrates the **Luasnip snippet engine** with the **nvim-cmp
          completion framework**.


        * **What features does it offer?**
          
          * Enhances the **completion experience** by allowing users to expand snippets while typing.
          * Provides quick access to **predefined code snippets** within the context of code completion.
          * Streamlines the process of **inserting and using snippets** alongside other **completion sources**
            in Neovim.


    * **3** `Friendly Snippets`

        * **What is Friendly Snippets?**
          
          * Friendly Snippets is a Neovim plugin designed to simplify the **creation and management** of
            **code snippets**.


        * **What features does it offer?**
          
          * Provides a collection of **predefined snippets** for various programming languages and frameworks.
          * Makes it easier for users to **insert common code patterns** with minimal effort.
          * Offers a library of **reusable code snippets** accessible through **simple triggers**.


    * **4** `Cmp Nvim LSP`

        * **What is Cmp Nvim LSP?**
          
          * Cmp-nvim-lsp is a Neovim plugin that integrates the **nvim-cmp completion framework** with the
            built-in **Language Server Protocol (LSP)** client in Neovim


        * **What features does it offer?**
          
          * Enhances **code completion** by providing **intelligent suggestions** based on the capabilities of
            **LSP servers** for various programming languages.
          * Enables seamless integration of **LSP-powered completion features** into Neovim.
          * Offers **context-aware suggestions**.


    * **5** `Nvim Cmp`

        * **What is Nvim Cmp?**
          
          * Nvim-cmp is a **powerful completion framework** for Neovim that enhances **code completion
            capabilities** within the editor.


        * **What features does it offer?**
          
          * Provides a **fast and customizable interface** for **context-aware completion** suggestions.
          * Supports various **completion sources** such as language servers, snippets, and more.
          * Offers **intelligent and efficient** code completion features.
          * Helps users write code **faster** and **with fewer errors**.


    * **6** `Cmp Buffer`

        * **What is Cmp Buffer?**
          
          * Cmp-buffer is a Neovim plugin that **extends the functionality of the nvim-cmp completion
            framework** by adding a **completion source** that suggests items from **currently open buffers**.


        * **What features does it offer?**
          
          * Enhances **code completion** by providing suggestions **based on the contents of buffers**.
          * Allows users to **quickly access** and **insert previously written code snippets** or references
            within their current editing session.
          * Further enriches the **completion experience** in Neovim
          * Offers a convenient way to **access and reuse code** from existing buffers **while
            writing new code**.


    * **7** `Cmp Path`

        * **What is Cmp Path?**
          
          * Cmp-path is a Neovim plugin designed to enhance the **completion capabilities** of the **nvim-cmp 
            completion framework** by adding a **completion source** that **suggests file paths** relative
            to the **current working directory**.


        * **What features does it offer?**
           
          * Facilitates **code completion** by providing **quick access to files** within the **project
            directory structure**.
          * Allows users to **efficiently navigate** and **include file paths** in their code **without
            manually typing them out**.
          * Offers **context-aware file path suggestions**.
          * Improvs productivity and **reduces typing efforts** during coding sessions.


* **Below the installation steps for the plugins:**

* `Step 1` **Write the configs** 


    * You're going to have to open a dedicated `cmp.lua` file inside the folder where you store all Java 
      related plugins `plugins/java/` to install and configure all the plugins above.
     ```lua 
     return {
         {
             "L3MON4D3/LuaSnip",
             dependencies = {
                 -- feed luasnip suggestions to cmp
                 "saadparwaiz1/cmp_luasnip",
                 -- provide vscode like snippets to cmp
                 "rafamadriz/friendly-snippets",
             }
         },
         -- cmp-nvim-lsp provides language specific completion suggestions to nvim-cmp
         {
             "hrsh7th/cmp-nvim-lsp",
         },
         -- nvim-cmp provides auto completion and auto completion dropdown ui
         {
             "hrsh7th/nvim-cmp",
             event = "InsertEnter",
             dependencies = {
                 -- buffer based completion options
                 "hrsh7th/cmp-buffer",
                 -- path based completion options
                 "hrsh7th/cmp-path",
             },
             config = function()
                 -- Gain access to the functions of the cmp plugin
                 local cmp = require("cmp")
                 -- Gain access to the function of the luasnip plugin
                 local luasnip = require("luasnip")
     
                 -- Lazily load the vscode like snippets
                 require("luasnip.loaders.from_vscode").lazy_load()
     
                 -- All the cmp setup function to configure our completion experience
                 cmp.setup({
                     -- How should completion options be displayed to us?
                     completion = {
                         -- menu: display options in a menu
                         -- menuone: automatically select the first option of the menu
                         -- preview: automatically display the completion candiate as you navigate the menu
                         -- noselect: prevent neovim from automatically selecting a completion option while navigating the menu
                         competeopt = "menu,menuone,preview,noselect"
                     },
                     -- setup snippet support based on the active lsp and the current text of the file
                     snippet = {
                         expand = function(args)
                             luasnip.lsp_expand(args.body)
                         end
                     },
                     -- setup how we interact with completion menus and options
                     mapping = cmp.mapping.preset.insert({
                          -- previous suggestion
                         ["<C-k>"] = cmp.mapping.select_prev_item(),
                         -- next suggestion
                         ["<C-j>"] = cmp.mapping.select_next_item(),
                         ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                         ["<C-f>"] = cmp.mapping.scroll_docs(4),
                         -- show completion suggestions
                         ["<C-Space"] = cmp.mapping.complete(),
                         -- close completion window
                         ["<C-e>"] = cmp.mapping.abort(),
                         -- confirm completion, only when you explicitly selected an option
                         ["<CR>"] = cmp.mapping.confirm({ select = false})
                     }),
                     -- Where and how should cmp rank and find completions
                     -- Order matters, cmp will provide lsp suggestions above all else
                     sources = cmp.config.sources({
                         { name = 'nvim_lsp' },
                         { name = 'luasnip' },
                         { name = 'buffer' },
                         { name = 'path' }
                     })
                 })
             end
         }
     }
     
     ```



* `Step 2` **Call the plugins in central plugin manager `plugins/init.lua` file**


    * Update the `plugins/init.lua` - central plugin loader to include `plugins/java/cmp.lua` plugin:
     ```lua 
     -- Load plugins from the 'java' development group
     
     -- other plugins...
     -- Add this line below for cmp plugin:
     extend_plugins(require("plugins.java.cmp"))
     
     ```


* **Set up Ghost Text** (Optional)


    * If you want to have the **cmp features** defined below, you can set those by following up:

     * **Ghost text** (or "Inline Completion") - a completion suggestion that appears directly in your appears
       **directly in you editing buffer**, usually in faded, lighter or otherwise visually distinct color to the
       **right of the cursor** as you type.

    * In `plugins/java/cmp.lua` file you opened earlier you can write this configs, if you remove the the ones 
      from the **Steps 1 and 2** because NvChad supports those **by default**.
     ```lua
     -- ~/.config/nvim/lua/plugins/java/cmp.lua
     
     return {
       {
         "hrsh7th/nvim-cmp",
         -- The 'opts' function receives NvChad's default options for nvim-cmp.
         -- You modify these options directly.
         opts = function(_, opts)
           -- Ensure the 'experimental' table exists
           opts.experimental = opts.experimental or {}
     
           -- Explicitly set ghost_text to true
           opts.experimental.ghost_text = true
     
           -- You can add other cmp customizations here if needed,
           -- or merge them with NvChad's existing settings.
           -- For example, to ensure 'preview' and 'noselect' are in completeopt:
           -- opts.completion.completeopt = opts.completion.completeopt .. ",preview,noselect"
     
           -- NvChad usually sets preselect. If you want to be extra sure:
           -- opts.preselect = require("cmp.types").cmp.Preselect.Item
     
           -- Always return the modified options table
           return opts
         end,
       },
     }
     
     ``` 

    * Keep the plugin call on `plugins/init.lua` for this configurations to work.


>[!NOTE]
This is the final step to give NeoVim IDE like feel. From now on you're going to start to get into some of the 
optional ones!

>You technically dont need any of the other ones forward, but those are gonna be more or less the **quality of 
life** things, that's kind of ment to make NeoVim little bit more fun to use, and make things easier for yourself


# Harpoon

* **What is Harpoon?**
    * Harpoon is a plugin developed by famous YouTube creator **Primegen** 
    * It is a plugin that enables NeoVim users to **mark files** inside your NeoVim instance for **easier 
      navigation**.
 

###### Installation and Set up


open the new file `plugins/java/harpoon.lua`



# Comment

* **What is Comment:**
    * Comment is a NeoVim plugin that provides easy comment and uncomment blocks.


###### Installation and Set up


open new file `plugins/java/comment.lua`


---
# Git

plugins:
`gitsigns`
`git-fugutives`


###### Installation & Set up


open `plugins/java/git.lua` files:




>[!TIP]
All the plugins you're going to see below are included in NvChad by defauld and not generally recommended to 
change the defaults. But if you want to learn about the configurations and capabilities of those bolow you can 
take a look!


---
# Autopairs

* **What is Autpairs?**
   * It is a plugin that **automatically close** your **curly braces {}**, **parentheses ()**, and **braces []**.

---
###### Installation and Set up


make the file called `plugins/java/autopairs.lua` 


note: it is supported in NvChad by default, but by setting up the plugin, you can access all the completions and code documentations.


# Lualine

it is a stylstic plugin that adds a little information line add the bottom, and it makes editor look a lot prettier.



###### Installation & Set up

open the new file `plugins/java/lualine.lua`



# Wich key


allows to see which keymapping are available based on the prefix that you just used.

###### Installation & Set up

open the new file `plugins/java/whichkey.lua`




