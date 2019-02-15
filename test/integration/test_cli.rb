require "methadone/test/base_integration_test"

class TestSomething < Methadone::BaseIntegrationTest
  def test_truth
    stdout,stderr,results = run_app("cg-scout","--help")
    assert_banner(stdout, "cg-scout", takes_options: true, takes_arguments: false)
    assert_option(stdout,"-h", "--help")
    assert_option(stdout,"--version")
    assert_oneline_summary(stdout)
  end
end
