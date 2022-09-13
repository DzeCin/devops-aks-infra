# Main purpose of this directory

This directory has been made to be used as a template for new ansible projects.

It follows the ansible best practice for the directory layout. Checkout <https://docs.ansible.com/ansible/latest/user_guide/sample_setup.html#alternative-directory-layout> for more information on what each sub-dir is used for.

This directory contains a simple ansibe role `example-role` and two inventory directories named `production` and `staging`. Delete those directories when using this template.

To run the `example-role`, use `ansible-playbook -i inventories/production main.yml`.

# How to use this ?

- clone this repo
- `cp -r ansible/template /path/to/working/dir/my-ansible-project`
- `cd /path/to/working/dir/my-ansible-project`
- `rm -rf inventories/{production,staging} roles/example-role`

# Tips

When using ansible playbooks on a set of hosts which are not listed in your `~/.ssh/known_hosts`, you can add the `--ssh-common-args='-o StrictHostKeyChecking=no'` option when running the `ansible-playbook` command.

> Ex: `ansible-playbook -u "bob" --ssh-common-args='-o StrictHostKeyChecking=no' -i path/to/inventory main.yml`
