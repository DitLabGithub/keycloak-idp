<#-- login.ftl - Simple Keycloak login page with persona dropdown -->
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${msg("loginTitle", (realm.displayName!''))}</title>
    <#if properties.styles?has_content>
        <#list properties.styles?split(' ') as style>
            <link href="${url.resourcesPath}/${style}" rel="stylesheet" />
        </#list>
    </#if>
</head>
<body>
    <div class="login-container">
        <div class="login-card">
        
            <#if properties.logo?has_content>
                <#list properties.logo?split(' ') as logo>
                    <img src=${url.resourcesPath}/${logo}>
                </#list>
            </#if>

            <#if message?has_content && (message.type != 'warning' || !isAppInitiatedAction??)>
                <div class="alert alert-${message.type}">
                    <#if message.type = 'success'><span class="success"></span></#if>
                    <#if message.type = 'warning'><span class="warning"></span></#if>
                    <#if message.type = 'error'><span class="error"></span></#if>
                    <#if message.type = 'info'><span class="info"></span></#if>
                    <span class="message-text">${kcSanitize(message.summary)?no_esc}</span>
                </div>
            </#if>
            
            <form id="kc-form-login" action="${url.loginAction}" method="post">
                <h2>Select a persona</h2>
                <div class="form-group">
                    <select id="persona-dropdown" class="form-control">
                        <option value="">-- Choose Persona --</option>
                        <option value="Reimer">Reimer (Face)</option>
                        <option value="Remco">Remco (The long fella)</option>
                    </select>
                </div>

                <input type="hidden" id="username" name="username" />
                <input type="hidden" id="password" name="password" />
                
                <div class="form-group">
                    <button type="button" class="btn btn-primary btn-block btn-lg" onclick="fillAndSubmit()">Login</button>
                </div>
            </form>
        </div>
    </div>

    <script>
        const personas = {
            Reimer: { username: 'Reimer', password: 'password123' },
            Remco: { username: 'Remco', password: 'IkBenGeenTauren' }
        };

        function fillAndSubmit() {
            const selected = document.getElementById('persona-dropdown').value;
            const persona = personas[selected];
            if (!persona) {
                alert("Please select a persona.");
                return false;
            }

            document.getElementById('username').value = persona.username;
            document.getElementById('password').value = persona.password;
            document.getElementById('kc-form-login').submit();
            return true;
        }
    </script>
</body>
</html>
