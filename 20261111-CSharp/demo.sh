cd /work
dotnet --version
for f in hello linq records async; do
    echo "=== $f.cs ==="
    dotnet run $f.cs
done
