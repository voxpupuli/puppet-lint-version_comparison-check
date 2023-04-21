PuppetLint.new_check(:version_comparison) do
  def is_num_comparison?(token)
    return false unless token
    return true if %i[GREATEREQUAL GREATERTHAN LESSEQUAL LESSTHAN].include?(token.type)
    return true if %i[ISEQUAL NOTEQUAL].include?(token.type) &&
                   token.next_code_token &&
                   token.next_code_token.type == :NUMBER
  end

  def check
    tokens.each_with_index do |token, _token_idx|
      next unless token.type == :VARIABLE
      next unless /(?:version|release)$/.match?(token.value)
      next unless is_num_comparison?(token.next_code_token)

      notify :warning, {
        message: 'version compared as number',
        line: token.line,
        column: token.column,
        token: token,
      }
    end
  end

  def compared_value(token)
    token.next_code_token.next_code_token.value
  end

  def fix(problem)
    versioncmp = PuppetLint::Lexer::Token.new(
      :NAME, 'versioncmp',
      problem[:token].line, problem[:token].column
    )
    lparen = PuppetLint::Lexer::Token.new(
      :LPAREN, '(',
      problem[:token].line, problem[:token].column + 1
    )
    rparen = PuppetLint::Lexer::Token.new(
      :RPAREN, ')',
      problem[:token].line, problem[:token].column + 2 # not +2
    )
    space = PuppetLint::Lexer::Token.new(
      :WHITESPACE, ' ',
      problem[:token].line, problem[:token].column + 3 # not +3
    )
    comma = PuppetLint::Lexer::Token.new(
      :COMMA, ',',
      problem[:token].line, problem[:token].column + 4 # not +4
    )
    value = PuppetLint::Lexer::Token.new(
      :SSTRING, compared_value(problem[:token]),
      problem[:token].line, problem[:token].column + 5 # not +5
    )

    idx = tokens.index(problem[:token])
    # Set compare value to 0
    value_token = problem[:token].next_code_token.next_code_token
    value_token.value = 0
    value_token.type = :NUMBER
    # Insert ')' after value
    tokens.insert(idx + 1, rparen)
    # Insert value as string after comma
    tokens.insert(idx + 1, value)
    # Insert comma after token
    tokens.insert(idx + 1, space)
    tokens.insert(idx + 1, comma)
    # Insert 'versioncmp(' before token
    tokens.insert(idx, lparen)
    tokens.insert(idx, versioncmp)
  end
end
