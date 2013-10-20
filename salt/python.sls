{% for python in ('python', 'python3') %}
{{ python }}:
  pkg.latest:
    - pkgs:
      - {{ python }}
      - {{ python }}-dev


{{ python }}-pip:
  pkg.latest
{% endfor %}


python-packages:
  pkg.latest:
    - pkgs:
      - python-imaging
      - python-recaptcha
      - python-virtualenv
      - python-django
      - python-django-south
      - python-django-tinymce
    - require:
      - pkg: python
