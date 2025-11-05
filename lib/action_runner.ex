defmodule ActionRunner do
  def run_action() do
    
  end
end

# defmodule SmartCompose do
#     def F(f1, f2) when is_function(f1, 0) and is_function(f2, 1) do
#     result1 = f1.()
#
#     cond do
#       is_list(result1) ->
#           # f1 returned a list
#           try do
#           # Try passing list directly
#           f2.(result1)
#         rescue
#           FunctionClauseError ->
#               # If f2 can’t handle a list, map over elements
#               Enum.map(result1, f2)
#           end
#
#         true ->
#         # f1 returned a scalar
#         try do
#           f2.(result1)
#         rescue
#           FunctionClauseError ->
#               # f2 might expect a list
#               f2.([result1])
#           end
#       end
#     end
# end

