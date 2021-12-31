# RIJX ESLint config

RIJX flavored ESLint config.

## How to use

Run the following command:

```
yarn add --dev eslint eslint-config-rijx eslint-plugin-import prettier eslint-plugin-prettier
```

Then put the following in `.eslintrc.js`:

```javascript
module.exports = {
  extends: ["rijx/recommended"],
};
```

## VSCode configuration

You can use the following configuration in `.vscode/settings.json` to automatically apply simple fixes. Improves performance dramatically.

```json
{
  "javascript.validate.enable": false,
  "typescript.validate.enable": false,
  "editor.formatOnSave": true,
  "editor.codeActionsOnSave": {
    "source.fixAll": true
  },
  "eslint.run": "onSave"
}
```

## License

MIT
