# Electric Monk

## Getting Started

1. You must have the following dependencies installed:

     - Ruby 3
          - See [`.ruby-version`](.ruby-version) for the specific version.
     - Node 19
          - See [`.nvmrc`](.nvmrc) for the specific version.
     - PostgreSQL 14
     - Redis 6.2
     - [Chrome](https://www.google.com/search?q=chrome) (for headless browser tests)

    If you don't have these installed, you can use [rails.new](https://rails.new) to help with the process.

2. Run the `bin/setup` script.
3. Start the application with `bin/dev`.
4. Visit http://localhost:3000.

## Information about Bullet Train
If this is your first time working on a Bullet Train application, be sure to review the [Bullet Train Basic Techniques](https://bullettrain.co/docs/getting-started) and the [Bullet Train Developer Documentation](https://bullettrain.co/docs).

### Render

[![Deploy to Render](https://render.com/images/deploy-to-render-button.svg)](https://render.com/deploy?repo=https://github.com/bullet-train-co/bullet_train)

Clicking this button will take you to the first step of a process that, when completed, will provision production-grade infrastructure for your Bullet Train application which will cost about **$30/month**.

When you're done deploying to Render, you need to go into "Dashboard" > "web", copy the server URL, and then go into "Env Groups" > "settings" and paste the URL into the value for `BASE_URL`.

### The list of super scaffold commands called

* rails generate super_scaffold Verb Team name:text_field description:trix_editor
* rails generate super_scaffold Noun Team name:text_field description:trix_editor
* rails generate super_scaffold Act Verb,Team  name:text_field description:trix_editor
* rails generate super_scaffold:field Act calling_verb_id:super_select{class_name=Verb}
* rails generate super_scaffold Flow Act,Verb,Team name:text_field description:trix_editor
* rails generate super_scaffold:field Flow to_act_id:super_select{class_name=Act}
* rails generate super_scaffold Operand Act,Verb,Team name:text_field description:trix_editor
* rails generate super_scaffold:field Operand noun_id:super_select{class_name=Noun}
