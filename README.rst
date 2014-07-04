valid_nanp - Validate phone numbers according to the North American Numbering Plan
##################################################################################

Read the article `valid_nanp - Validate phone numbers according to the North
American Numbering Plan
<http://www.stevepiercy.com/articles/valid_nanp-validate-phone-numbers-according-to-the-north-american-numbering-plan/>`_.

Description
===========

``[valid_nanp]`` determines whether a string contains a valid phone number
according to the `North American Numbering Plan
<http://en.wikipedia.org/wiki/North_American_Numbering_Plan>`_. Validation
ignores all non-numeric characters. Additionally the number must have at least
10 digits and cannot begin with ``+1``. Phone numbers with extensions are
permitted, where any digit beyond the first 10 digits forms the extension.
Optionally formats the output, substituting ``#`` for digits, and inserting
any other arbitrary character.

Demo
====

`Demo <http://www.stevepiercy.com/lasso/valid_nanp_demo/>`_.

Usage
=====

``valid_nanp`` accepts two parameters.

``-number`` is required and must be a string type. This is the phone number to
be validated and optionally formatted.

``-format`` is optional and must be a string type. This is the output format.

Examples
========

.. code-block:: lasso

    valid_nanp('631-960-7187');

.. code-block:: text

    => true

.. code-block:: lasso

    valid_nanp('401-285-0696', -format='(###) ###-#### x######');

.. code-block:: text

    => (401) 285-0696

.. code-block:: lasso

    valid_nanp('oogahboogah401oopsie-285-0696ext12345', -format='(###) ###-#### x######');

.. code-block:: text

    => (401) 285-0696 x12345


Installation
============

The repository contains both the tag ``[valid_nanp]`` in a file named
``valid_nanp.lasso`` and a directory ``valid_nanp_demo`` containing the demo.
In this directory there is a web page named ``index.lasso`` containing the
``valid_nanp`` tag and a web form.
