<#-- login.ftl -->
<html>
<head>
  <title>Login</title>
  <link rel="stylesheet" href="${url.resourcesPath}/css/login.css" />
</head>
<body>
  <h2>Select a persona</h2>

  <form id="kc-form-login" onsubmit="fillAndSubmit()" method="post">
    <select id="persona-dropdown">
      <option value="">-- Choose Persona --</option>
      <option value="alice">Alice (Admin)</option>
      <option value="bob">Bob (User)</option>
    </select>

    <input type="hidden" id="username" name="username" />
    <input type="hidden" id="password" name="password" />
    <input type="submit" value="Login" />
  </form>

  <script>
    const personas = {
      alice: { username: 'alice', password: 'alice' },
      bob: { username: 'bob', password: 'bob' }
    };

    function fillAndSubmit() {
      const selected = document.getElementById('persona-dropdown').value;
      const persona = personas[selected];
      if (!persona) {
        alert("Please select a persona.");
        event.preventDefault();
        return;
      }
      document.getElementById('username').value = persona.username;
      document.getElementById('password').value = persona.password;
    }
  </script>
</body>
</html>
