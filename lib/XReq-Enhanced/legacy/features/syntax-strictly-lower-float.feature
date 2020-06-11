Feature: Scenario Strictly Lower For Float 
  In order to write scenarios that can check if the actual value is strictly lower than the expected
  As a feature writer
  I want xreq to support stricly lower checks in steps

  Background:
    Given xreq is in the PATH
    And I am in the xreq directory

  Scenario: Actual is strictly lower than expected 
    Given a file "features/data/tmp-strictly-lower-float.feature":
      """
      Feature: heating

        Scenario Outline: heating
          Given temperature is <start> degrees
          When I heat for <heat> degrees
          Then the temperature shall be <end> degrees

          Examples:
            | start     | heat      | end      |
            | 0.8382343 | 7.1516244 | <8.00013 |

      """
    When I run xreq -m -x suite features/data/tmp-strictly-lower-float.feature
    Then it should pass
    When I run the test suite "./suite" in features/data/tests
    Then it should pass with
      """
      Feature: heating

        Scenario Outline: heating
          Given temperature is <start> degrees
          When I heat for <heat> degrees
          Then the temperature shall be <end> degrees

          Examples:
            | start     | heat      | end      |
            | 0.8382343 | 7.1516244 | <8.00013 |

      1 scenario (1 passed)
      3 steps (3 passed)

      """

  Scenario: Actual equals expected 
    Given a file "features/data/tmp-strictly-lower-float1.feature":
      """
      Feature: heating

        Scenario Outline: heating
          Given temperature is <start> degrees
          When I heat for <heat> degrees
          Then the temperature shall be <end> degrees

          Examples:
            | start     | heat      | end        |
            | 0.8382343 | 7.1516244 | <7.9898587 |

      """
    When I run xreq -m -x suite features/data/tmp-strictly-lower-float1.feature
    Then it should pass
    When I run the test suite "./suite" in features/data/tests
    Then it should fail 

  Scenario: Actual strictly smaller than expected 
    Given a file "features/data/tmp-strictly-lower-float2.feature":
      """
      Feature: heating

        Scenario Outline: heating
          Given temperature is <start> degrees
          When I heat for <heat> degrees
          Then the temperature shall be <end> degrees

          Examples:
            | start   | heat    | end      |
            | 0.83823 | 7.15162 | <7.98984 |

      """
    When I run xreq -m -x suite features/data/tmp-strictly-lower-float2.feature
    Then it should pass
    When I run the test suite "./suite" in features/data/tests
    Then it should fail 
