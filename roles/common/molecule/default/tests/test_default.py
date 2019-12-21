import os

import testinfra.utils.ansible_runner

testinfra_hosts = testinfra.utils.ansible_runner.AnsibleRunner(
    os.environ['MOLECULE_INVENTORY_FILE']
).get_hosts('all')


def test_firewalld_installed(host):
    firewalld = host.package("firewalld")
    assert firewalld.is_installed


def test_cockpit_installed(host):
    cockpit = host.package("cockpit")
    assert cockpit.is_installed


# TODO: Figure out why this fails on Centos7 and Fedora30
# def test_firewalld_running_and_enabled(host):
#     firewalld = host.service("firewalld")
#     assert firewalld.is_running
#     assert firewalld.is_enabled


def test_cockpit_enabled(host):
    cockpit = host.service("cockpit")
    assert cockpit.is_enabled


def test_user_bubba_created(host):
    user = host.user("bubba")
    assert user.exists
    assert user.shell == "/bin/zsh"
    assert user.home == "/home/bubba"


def test_user_blink404_created(host):
    user = host.user("blink-404")
    assert user.exists
    assert user.shell == "/bin/bash"
    assert user.home == "/home/blink-404"
