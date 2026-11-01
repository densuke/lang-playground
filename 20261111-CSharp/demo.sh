cd /work
dotnet --version
for f in hello query linq records async; do
    echo "=== $f.cs ==="
    dotnet run $f.cs
done
