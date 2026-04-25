function Reader(input)
  return pandoc.Pandoc({
    pandoc.CodeBlock(tostring(input))
  })
end