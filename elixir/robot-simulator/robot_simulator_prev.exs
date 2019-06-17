defmodule RobotSimulator do
  @doc """
  Create a Robot Simulator given an initial direction and position.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec create(direction :: atom, position :: {integer, integer}) :: any
  def create(direction \\ :north, position \\ {0,0}) do
    with :ok <- valid_direction?(direction),
         :ok <- valid_position?(position)
    do
        %{direction: direction, position: position}
    end
  end

  @doc """
  Simulate the robot's movement given a string of instructions.

  Valid instructions are: "R" (turn right), "L", (turn left), and "A" (advance)
  """
  @spec simulate(robot :: any, instructions :: String.t()) :: any
  def simulate(robot, instructions) do
    instructions
    |> String.codepoints
    |> Enum.reduce_while(robot, fn instruction, acc ->
        case acc = move(acc, instruction) do
          {:error, _msg} -> {:halt, acc}
          _ -> {:cont, acc}
        end
    end)
  end

  @doc """
  Return the robot's direction.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec direction(robot :: any) :: atom
  def direction(%{direction: dir}), do: dir

  @doc """
  Return the robot's position.
  """
  @spec position(robot :: any) :: {integer, integer}
  def position(%{position: pos}), do: pos

  defguardp is_valid_direction(dir) when dir in [:north, :east, :south, :west]

  defp valid_direction?(direction) when is_valid_direction(direction), do: :ok

  defp valid_direction?(_direction), do: {:error, "invalid direction"}

  defguardp is_valid_coordinates(x, y) when is_integer(x) and is_integer(y)

  defp valid_position?({x,y}) when is_valid_coordinates(x,y), do: :ok

  defp valid_position?(_position), do: {:error, "invalid position"}

  defp move(robot, "L"), do: %{ robot | direction: turn_left(robot.direction) }

  defp move(robot, "R"), do: %{ robot | direction: turn_right(robot.direction) }

  defp move(robot, "A"), do: %{ robot | position: advance(robot.direction, robot.position) }

  defp move(_robot, _instruction), do: {:error, "invalid instruction"}

  defp turn_left(direction) do
    case direction do
      :north -> :west
      :east -> :north
      :south -> :east
      :west -> :south
    end
  end

  defp turn_right(direction) do
    case direction do
      :north -> :east
      :east -> :south
      :south -> :west
      :west -> :north
    end
  end

  defp advance(direction, {x, y} = _position) do
    case direction do
      :north -> {x,   y+1}
      :east  -> {x+1, y}
      :south -> {x,   y-1}
      :west  -> {x-1, y}
    end
  end
end
